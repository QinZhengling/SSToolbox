// 引入必要的装饰器
import { AddRecordDialog, EditRecordDialog } from './Dialog'

enum RecordType {
  COUNTDOWN = 'COUNTDOWN',
  ASSET = 'ASSET'
}

// 1. 定义数据模型
class RecordItem {
  id: string;
  title: string;
  type: RecordType;
  date: Date; // 目标日期或购买日期
  price?: number; // 价格（资产特有）

  constructor(id: string, title: string, type: RecordType, date: Date, price?: number) {
    this.id = id;
    this.title = title;
    this.type = type;
    this.date = date;
    this.price = price;
  }
}

// 扩展数据模型，包含计算后的天数
class RecordItemWithDays extends RecordItem {
  days: number;

  constructor(recordItem: RecordItem, days: number) {
    super(recordItem.id, recordItem.title, recordItem.type, recordItem.date, recordItem.price);
    this.days = days;
  }
}

// 滑动操作按钮配置接口
interface SwipeActionButtonConfig {
  text: string;
  backgroundColor: Color | string;
  zIndex: number;
  translateX: number;
  borderRadius: BorderRadiusOptions;
  onClick: () => void;
}

// 圆角选项接口
interface BorderRadiusOptions {
  topLeft?: number;
  topRight?: number;
  bottomLeft?: number;
  bottomRight?: number;
}

// 滑动效果接口
interface SwipeEffectResult {
  leftReduction: number;
  rightReduction: number;
}

// 显示内容接口定义
interface AssetDisplayContent {
  priceText: string;
  daysText: string;
}

interface CountdownDisplayContent {
  daysText: string;
  suffixText: string;
}

@Entry
@Component
struct Index {
  // 安全区域高度
  @State topSafeAreaHeight: number = 0;

  @State openSwipeId: string = '';
  @State openSwipeSide: 'none' | 'start' | 'end' = 'none';
  // 2. 准备测试数据 (@State 装饰器表示这是状态变量，数据改变时会刷新UI)
  @State recordList: RecordItem[] =[
    new RecordItem('1', 'MacBook Pro', RecordType.ASSET, new Date('2023-10-01'), 14999),
    new RecordItem('2', '女朋友生日', RecordType.COUNTDOWN, new Date('2026-05-20')),
    new RecordItem('3', '降噪耳机', RecordType.ASSET, new Date('2024-01-15'), 1999),
    new RecordItem('4', '发工资', RecordType.COUNTDOWN, new Date('2026-03-10'))
  ];

  // 包含计算天数的数据列表
  @State processedList: RecordItemWithDays[] = [];

  // 编辑模式相关状态
  @State isEditing: boolean = false;
  @State editingItem: RecordItemWithDays | null = null;

  // 滑动操作菜单状态
  @State currentSwipeIndex: number = -1; // 当前滑动的卡片索引
  @State swipeOffsetX: number = 0; // 卡片侧滑位移
  @State cardScale: number = 1.0; // 卡片缩放比例

  // 交互状态
  @State pressedItemId: string = ''; // 当前按下的项目ID

  // 3. 核心计算逻辑：计算相隔天数
  getDaysDiff(targetDate: Date, isAsset: boolean): number {
    const today = new Date();
    today.setHours(0, 0, 0, 0); // 清除时分秒的影响
    const target = new Date(targetDate);
    target.setHours(0, 0, 0, 0);

    const diffTime = target.getTime() - today.getTime();
    let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    // 如果是资产（过去的时间），天数取绝对值。如果今天刚买，按1天算防止除以0
    if (isAsset) {
      diffDays = Math.abs(diffDays);
      return diffDays === 0 ? 1 : diffDays;
    }
    // 倒数日
    return diffDays;
  }

  // 4. 核心计算逻辑：计算每日均价
  getDailyPrice(price: number, days: number): string {
    if (days <= 0) return '0.00';
    const daily = price / days;
    return isNaN(daily) ? '0.00' : daily.toFixed(2);
  }

  // 格式化日期显示
  formatDate(date: Date): string {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  // 5. 数据预处理：将原始数据转换为包含天数的数据
  processData(): void {
    this.processedList = this.recordList.map(item => {
      const days = this.getDaysDiff(item.date, item.type === RecordType.ASSET);
      return new RecordItemWithDays(item, days);
    });
  }

  // 6. 生命周期：组件将要出现时处理数据
  aboutToAppear() {
    this.processData();
    this.getSafeAreaHeight();
  }

  // 获取安全区域高度
  getSafeAreaHeight(): void {
    try {
      // 简化安全区域获取方式，使用固定值
      this.topSafeAreaHeight = 48; // 默认状态栏高度
    } catch (error) {
      console.error('获取安全区域高度失败:', error);
      this.topSafeAreaHeight = 48; // 默认值
    }
  }

  // 删除记录
  deleteRecord(itemId: string): void {
    const index = this.recordList.findIndex(item => item.id === itemId);
    if (index !== -1) {
      this.recordList.splice(index, 1);
      this.processData();
    }
  }

  // 开始编辑记录
  startEditRecord(item: RecordItemWithDays): void {
    this.isEditing = true;
    this.editingItem = item;
  }

  // 保存编辑
  saveEditRecord(updatedItem: RecordItem): void {
    if (!this.editingItem) return;

    const index = this.recordList.findIndex(item => item.id === this.editingItem!.id);
    if (index !== -1) {
      this.recordList[index] = updatedItem;
      this.processData();
    }

    this.cancelEdit();
  }

  // 取消编辑
  cancelEdit(): void {
    this.isEditing = false;
    this.editingItem = null;
    this.currentSwipeIndex = -1;
  }

  // 实时圆角计算函数：基于滑动状态实时计算圆角
  private calculateRealTimeRadius(index: number, item: RecordItemWithDays, isSwipingLeft: boolean, isSwipingRight: boolean): BorderRadiusOptions {
    // 1. 基础圆角配置
    const baseRadius = 16;

    // 2. 基于索引的圆角效果
    const isFirstItem: boolean = (index === 0);
    const isLastItem: boolean = (index === this.processedList.length - 1);

    // 3. 基于滑动状态的圆角效果
    const isStartExpanded: boolean = (this.openSwipeId === item.id && this.openSwipeSide === 'start');
    const isEndExpanded: boolean = (this.openSwipeId === item.id && this.openSwipeSide === 'end');

    // 4. 基于记录类型的圆角效果
    const typeRadius: number = (item.type === RecordType.ASSET) ? 2 : 0;

    // 5. 基于交互状态的圆角效果
    const isPressed: boolean = (this.pressedItemId === item.id);

    // 6. 实时滑动效果影响
    const swipeEffect = this.calculateSwipeEffect(isSwipingLeft, isSwipingRight);

    let topLeft = baseRadius;
    let topRight = baseRadius;
    let bottomLeft = baseRadius;
    let bottomRight = baseRadius;

    // 1. 基于索引的圆角调整
    if (isFirstItem) {
      topLeft += 4;
      topRight += 4;
    }
    if (isLastItem) {
      bottomLeft += 4;
      bottomRight += 4;
    }

    // 2. 基于滑动状态的圆角调整
    if (isStartExpanded) {
      topLeft = 0;
      bottomLeft = 0;
    }
    if (isEndExpanded) {
      topRight = 0;
      bottomRight = 0;
    }

    // 3. 基于记录类型的圆角调整
    topLeft += typeRadius;
    bottomLeft += typeRadius;

    // 4. 基于交互状态的圆角调整
    if (isPressed) {
      topLeft += 2;
      topRight += 2;
      bottomLeft += 2;
      bottomRight += 2;
    }

    // 5. 实时滑动效果应用
    topLeft = Math.max(0, topLeft - swipeEffect.leftReduction);
    bottomLeft = Math.max(0, bottomLeft - swipeEffect.leftReduction);
    topRight = Math.max(0, topRight - swipeEffect.rightReduction);
    bottomRight = Math.max(0, bottomRight - swipeEffect.rightReduction);

    // 使用显式类型声明
    const borderRadius: BorderRadiusOptions = {
      topLeft: Math.max(0, topLeft),
      topRight: Math.max(0, topRight),
      bottomLeft: Math.max(0, bottomLeft),
      bottomRight: Math.max(0, bottomRight)
    };

    return borderRadius;
  }

  // 计算滑动效果的圆角变化
  private calculateSwipeEffect(isSwipingLeft: boolean, isSwipingRight: boolean): SwipeEffectResult {
    const maxRadiusReduction = 16; // 最大圆角减少量

    // 简化实现：当滑动时直接应用最大圆角减少
    if (isSwipingRight) {
      const result: SwipeEffectResult = { leftReduction: maxRadiusReduction, rightReduction: 0 };
      return result;
    } else if (isSwipingLeft) {
      const result: SwipeEffectResult = { leftReduction: 0, rightReduction: maxRadiusReduction };
      return result;
    } else {
      const result: SwipeEffectResult = { leftReduction: 0, rightReduction: 0 };
      return result;
    }
  }

  // 缓动函数：三次方缓出
  private easeOutCubic(t: number): number {
    return 1 - Math.pow(1 - t, 3);
  }

  // 原有的动态圆角计算函数（保留备用）
  private calculateDynamicRadius(index: number, item: RecordItemWithDays): BorderRadiusOptions {
    const isFirstItem: boolean = (index === 0);
    const isLastItem: boolean = (index === this.processedList.length - 1);
    const isStartExpanded: boolean = (this.openSwipeId === item.id && this.openSwipeSide === 'start');
    const isEndExpanded: boolean = (this.openSwipeId === item.id && this.openSwipeSide === 'end');
    const typeRadius: number = (item.type === RecordType.ASSET) ? 2 : 0;
    const isPressed: boolean = (this.pressedItemId === item.id);

    let topLeft = 16;
    let topRight = 16;
    let bottomLeft = 16;
    let bottomRight = 16;

    if (isFirstItem) {
      topLeft += 4;
      topRight += 4;
    }
    if (isLastItem) {
      bottomLeft += 4;
      bottomRight += 4;
    }

    if (isStartExpanded) {
      topLeft = 0;
      bottomLeft = 0;
    }
    if (isEndExpanded) {
      topRight = 0;
      bottomRight = 0;
    }

    topLeft += typeRadius;
    bottomLeft += typeRadius;

    if (isPressed) {
      topLeft += 2;
      topRight += 2;
      bottomLeft += 2;
      bottomRight += 2;
    }

    const waveEffect = (index % 3) * 1;
    topLeft += waveEffect;
    topRight += waveEffect;

    const borderRadius: BorderRadiusOptions = {
      topLeft: Math.max(0, topLeft),
      topRight: Math.max(0, topRight),
      bottomLeft: Math.max(0, bottomLeft),
      bottomRight: Math.max(0, bottomRight)
    };

    return borderRadius;
  }

  // 计算资产类型显示内容
  private getAssetDisplayContent(item: RecordItemWithDays): AssetDisplayContent {
    const content: AssetDisplayContent = {
      priceText: `¥ ${this.getDailyPrice(item.price ?? 0, item.days)}`,
      daysText: `已用 ${item.days} 天`
    };
    return content;
  }

  // 计算倒数日类型显示内容
  private getCountdownDisplayContent(item: RecordItemWithDays): CountdownDisplayContent {
    const days = item.days > 0 ? item.days : Math.abs(item.days);
    const suffix = item.days >= 0 ? '天后' : '天前';
    const content: CountdownDisplayContent = {
      daysText: `${days}`,
      suffixText: suffix
    };
    return content;
  }

  // 添加记录弹窗控制器
  addDialogController: CustomDialogController = new CustomDialogController({
    builder: AddRecordDialog({
      onConfirm: (newItem: RecordItem) => {
        // 当弹窗点击保存时，会触发这里
        this.recordList.push(newItem); // 添加到原始列表
        this.processData(); // 重新计算所有天数和均价，刷新UI
      }
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true
  })

  // 编辑记录弹窗控制器
  editDialogController: CustomDialogController = new CustomDialogController({
    builder: EditRecordDialog({
      item: this.editingItem,
      onConfirm: (updatedItem: RecordItem) => {
        this.saveEditRecord(updatedItem);
      },
      onCancel: () => {
        this.cancelEdit();
      }
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true
  })

  // ==========================================
  // Switch 左手柄 (右滑拉出) - 霓虹蓝 编辑
  // ==========================================
  @Builder
  EditSwipeAction(item: RecordItemWithDays) {
    Row() {
      Button('编辑')
        .width(76)
        .height('100%')
        .backgroundColor('#00C3E3') // Switch 经典左手柄蓝
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bolder)
        .fontSize(16)
        .type(ButtonType.Normal)
        .borderRadius({ topLeft: 16, bottomLeft: 16 }) // 仅保留左侧圆角
        .onClick(() => {
          this.startEditRecord(item);
          this.editDialogController.open();
        })
    }
    .height(96)
  }

  // ==========================================
  // Switch 右手柄 (左滑拉出) - 霓虹红 删除
  // ==========================================
  @Builder
  DeleteSwipeAction(item: RecordItemWithDays) {
    Row() {
      Button('删除')
        .width(76)
        .height('100%')
        .backgroundColor('#FF4D4F') // Switch 经典右手柄红
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bolder)
        .fontSize(16)
        .type(ButtonType.Normal)
        .borderRadius({ topRight: 16, bottomRight: 16 }) // 仅保留右侧圆角
        .onClick(() => {
          this.deleteRecord(item.id);
        })
    }
    .height(96)
  }

  // 简化版实时圆角效果：基于swipeAction状态实时计算圆角
  @Builder
  ItemCard(item: RecordItemWithDays, index: number) {
    Row() {
      // 左侧细长圆角色彩条分类标识
      Column() {
        Blank()
      }
      .width(6)
      .height(80)
      .backgroundColor(item.type === RecordType.ASSET ? '#FF4D4F' : '#00C3E3')
      .borderRadius({
        topLeft: this.calculateRealTimeRadius(index, item,
          (this.openSwipeId === item.id && this.openSwipeSide === 'end'),
          (this.openSwipeId === item.id && this.openSwipeSide === 'start')).topLeft,
        bottomLeft: this.calculateRealTimeRadius(index, item,
          (this.openSwipeId === item.id && this.openSwipeSide === 'end'),
          (this.openSwipeId === item.id && this.openSwipeSide === 'start')).bottomLeft,
        topRight: 0,
        bottomRight: 0
      })
      .margin({ right: 16 })
      .animation({ duration: 100, curve: Curve.EaseOut })

      // 主内容区域
      Column() {
        Text(item.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111111')
          .margin({ bottom: 6 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(item.type === RecordType.ASSET ? `购买日: ${this.formatDate(item.date)}` : `目标日: ${this.formatDate(item.date)}`)
          .fontSize(12)
          .fontColor('#999999')
          .maxLines(1)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .height(80)
      .justifyContent(FlexAlign.Center)

      // 右侧核心数据展示 - 使用内联三元表达式
      Column({ space: 2 }) {
        // 资产类型显示
        Row() {
          Text(item.type === RecordType.ASSET ? `¥ ${this.getDailyPrice(item.price ?? 0, item.days)}` : `${item.days > 0 ? item.days : Math.abs(item.days)}`)
            .fontSize(item.type === RecordType.ASSET ? 24 : 32)
            .fontWeight(FontWeight.Bold)
            .fontColor(item.type === RecordType.ASSET ? '#FF4D4F' : '#00C3E3')
            .maxLines(1)

          // 条件渲染单位文本
          Text(item.type === RecordType.ASSET ? ' /天' : (item.days >= 0 ? '天后' : '天前'))
            .fontSize(item.type === RecordType.ASSET ? 14 : 11)
            .fontColor(item.type === RecordType.ASSET ? '#FF4D4F' : '#AAAAAA')
            .fontWeight(FontWeight.Normal)
        }

        // 条件渲染天数文本
        Text(item.type === RecordType.ASSET ? `已用 ${item.days} 天` : '')
          .fontSize(11)
          .fontColor('#AAAAAA')
          .margin({ top: item.type === RecordType.ASSET ? 2 : 0 })
      }
      .alignItems(HorizontalAlign.End)
      .height(80)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(96)
    .padding({ left: 16, right: 20 })
    .backgroundColor(Color.White)
    .borderRadius(this.calculateRealTimeRadius(index, item,
      (this.openSwipeId === item.id && this.openSwipeSide === 'end'),
      (this.openSwipeId === item.id && this.openSwipeSide === 'start')))
    .shadow({
      radius: (this.pressedItemId === item.id) ? 12 : 8,
      color: (this.pressedItemId === item.id) ? 'rgba(0,0,0,0.15)' : 'rgba(0,0,0,0.06)',
      offsetY: (this.pressedItemId === item.id) ? 6 : 4
    })
    .animation({ duration: 100, curve: Curve.EaseOut })
    .onClick(() => {
      // 点击空白区域取消编辑模式
      this.cancelEdit();
    })
    .onTouch((event) => {
      // 触摸事件处理
      this.pressedItemId = event.type === TouchType.Down ? item.id : '';
    })
  }

  // 7. 构建 UI 界面
  build() {
    Column() {
      // 顶部安全区域占位
      Blank().height(this.topSafeAreaHeight)

      // 优化顶部栏 - 去除背景色增加透气感
      Row() {
        Column({ space: 2 }) {
          Text('我的时价')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111111')
          Text('记录生活中的美好时光')
            .fontSize(14)
            .fontColor('#888888')
            .fontWeight(FontWeight.Normal)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 添加按钮 - 悬浮圆形设计
        Column() {
          Button('+')
            .fontSize(28)
            .width(56)
            .height(56)
            .backgroundColor('#333333')
            .fontColor(Color.White)
            .type(ButtonType.Circle)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetY: 4 })
            .onClick(() => {
              this.addDialogController.open();
            })
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .padding({ top: 24, bottom: 24, left: 24, right: 24 })

      // 列表区 - 实时圆角侧滑布局
      List({ space: 12 }) {
        ForEach(this.processedList, (item: RecordItemWithDays, index: number) => {
          ListItem() {
            this.ItemCard(item, index)
          }
          .swipeAction({
            // 左侧：Switch 经典蓝 Joy-Con (右滑拉出)
            start: {
              builder: () => { this.EditSwipeAction(item) },
              onStateChange: (state: SwipeActionState) => {
                if (state === SwipeActionState.EXPANDED) {
                  this.openSwipeId = item.id;
                  this.openSwipeSide = 'start';
                } else if (state === SwipeActionState.COLLAPSED) {
                  if (this.openSwipeId === item.id) this.openSwipeSide = 'none';
                }
              }
            },
            // 右侧：Switch 经典红 Joy-Con (左滑拉出)
            end: {
              builder: () => { this.DeleteSwipeAction(item) },
              actionAreaDistance: 80, // Switch风格干脆利落，滑动80vp松手直接删除
              onAction: () => {
                this.deleteRecord(item.id);
              },
              onStateChange: (state: SwipeActionState) => {
                if (state === SwipeActionState.EXPANDED) {
                  this.openSwipeId = item.id;
                  this.openSwipeSide = 'end';
                } else if (state === SwipeActionState.COLLAPSED) {
                  if (this.openSwipeId === item.id) this.openSwipeSide = 'none';
                }
              }
            },
            edgeEffect: SwipeEdgeEffect.Spring
          })
        }, (item: RecordItemWithDays) => item.id)
      }
      .width('100%')
      .flexGrow(1)
      .padding({ left: 16, right: 16, top: 8 })
      .backgroundColor('#F7F7F7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7') // 极淡灰色背景
    .onClick(() => {
      // 点击空白区域取消编辑模式
      if (this.isEditing) {
        this.cancelEdit();
      }
    })
  }
}