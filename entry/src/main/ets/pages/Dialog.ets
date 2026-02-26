// 引入必要的装饰器 (ArkTS原生支持，无需额外import)
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

// 添加记录弹窗组件
@CustomDialog
export struct AddRecordDialog {
  controller: CustomDialogController;
  // 接收父组件传过来的确认回调函数
  onConfirm: (item: RecordItem) => void = () => {};

  // 表单状态变量
  @State currentType: RecordType = RecordType.COUNTDOWN;
  @State inputTitle: string = '';
  @State inputPrice: string = '';
  @State selectedDate: Date = new Date();

  build() {
    Column({ space: 15 }) {
      Text('添加新记录')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })

      // 1. 类型切换 (倒数日 / 资产)
      Row() {
        Button('倒数日')
          .layoutWeight(1)
          .backgroundColor(this.currentType === RecordType.COUNTDOWN ? '#4A90E2' : '#F0F0F0')
          .fontColor(this.currentType === RecordType.COUNTDOWN ? Color.White : '#666666')
          .onClick(() => this.currentType = RecordType.COUNTDOWN)

        Button('资产')
          .layoutWeight(1)
          .margin({ left: 10 })
          .backgroundColor(this.currentType === RecordType.ASSET ? '#E95F5F' : '#F0F0F0')
          .fontColor(this.currentType === RecordType.ASSET ? Color.White : '#666666')
          .onClick(() => this.currentType = RecordType.ASSET)
      }
      .width('100%')

      // 2. 标题输入
      TextInput({ placeholder: this.currentType === RecordType.COUNTDOWN ? '例如：女朋友生日' : '例如：MacBook Pro' })
        .onChange((value: string) => {
          this.inputTitle = value;
        })
        .backgroundColor('#F5F5F5')

      // 3. 价格输入 (仅资产模式显示)
      if (this.currentType === RecordType.ASSET) {
        TextInput({ placeholder: '请输入买入价格 (元)' })
          .type(InputType.Number) // 限制只能输入数字
          .onChange((value: string) => {
            this.inputPrice = value;
          })
          .backgroundColor('#F5F5F5')
      }

      // 4. 日期选择
      Row() {
        Text(this.currentType === RecordType.ASSET ? '购买日期:' : '目标日期:')
          .fontColor('#333333')
        Blank() // 撑开剩余空间
        Text(`${this.selectedDate.getFullYear()}-${this.selectedDate.getMonth() + 1}-${this.selectedDate.getDate()}`)
          .fontColor('#4A90E2')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
      .onClick(() => {
        // 唤起系统日期选择器
        DatePickerDialog.show({
          start: new Date("2000-1-1"),
          end: new Date("2100-12-31"),
          selected: this.selectedDate,
          onAccept: (value: DatePickerResult) => {
            this.selectedDate = new Date(value.year, value.month, value.day);
          }
        })
      })

      // 5. 底部操作按钮
      Row({ space: 15 }) {
        Button('取消')
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .fontColor('#999999')
          .onClick(() => {
            this.controller.close();
          })

        Button('保存')
          .layoutWeight(1)
          .backgroundColor('#333333')
          .onClick(() => {
            // 简单的表单校验
            if (!this.inputTitle) return;

            // 构造新数据并回调给父组件
            const newItem = new RecordItem(
              Date.now().toString(), // 用时间戳做临时ID
              this.inputTitle,
              this.currentType,
              this.selectedDate,
              this.currentType === RecordType.ASSET ? parseFloat(this.inputPrice) : undefined
            );
            this.onConfirm(newItem);
            this.controller.close();
          })
      }
      .margin({ top: 10 })
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}

// 编辑记录弹窗组件
@CustomDialog
export struct EditRecordDialog {
  controller?: CustomDialogController;
  // 接收父组件传过来的数据
  item: RecordItemWithDays | null = null;
  onConfirm: (item: RecordItem) => void = () => {};
  onCancel: () => void = () => {};

  // 表单状态变量
  @State currentType: RecordType = RecordType.COUNTDOWN;
  @State inputTitle: string = '';
  @State inputPrice: string = '';
  @State selectedDate: Date = new Date();

  aboutToAppear() {
    // 初始化表单数据
    if (this.item) {
      this.currentType = this.item.type;
      this.inputTitle = this.item.title;
      this.inputPrice = this.item.price?.toString() || '';
      this.selectedDate = this.item.date;
    }
  }

  build() {
    Column({ space: 15 }) {
      Text('编辑记录')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })

      // 1. 类型切换 (倒数日 / 资产)
      Row() {
        Button('倒数日')
          .layoutWeight(1)
          .backgroundColor(this.currentType === RecordType.COUNTDOWN ? '#4A90E2' : '#F0F0F0')
          .fontColor(this.currentType === RecordType.COUNTDOWN ? Color.White : '#666666')
          .onClick(() => this.currentType = RecordType.COUNTDOWN)

        Button('资产')
          .layoutWeight(1)
          .margin({ left: 10 })
          .backgroundColor(this.currentType === RecordType.ASSET ? '#E95F5F' : '#F0F0F0')
          .fontColor(this.currentType === RecordType.ASSET ? Color.White : '#666666')
          .onClick(() => this.currentType = RecordType.ASSET)
      }
      .width('100%')

      // 2. 标题输入
      TextInput({ 
        placeholder: this.currentType === RecordType.COUNTDOWN ? '例如：女朋友生日' : '例如：MacBook Pro',
        text: this.inputTitle
      })
        .onChange((value: string) => {
          this.inputTitle = value;
        })
        .backgroundColor('#F5F5F5')

      // 3. 价格输入 (仅资产模式显示)
      if (this.currentType === RecordType.ASSET) {
        TextInput({ 
          placeholder: '请输入买入价格 (元)',
          text: this.inputPrice
        })
          .type(InputType.Number) // 限制只能输入数字
          .onChange((value: string) => {
            this.inputPrice = value;
          })
          .backgroundColor('#F5F5F5')
      }

      // 4. 日期选择
      Row() {
        Text(this.currentType === RecordType.ASSET ? '购买日期:' : '目标日期:')
          .fontColor('#333333')
        Blank() // 撑开剩余空间
        Text(`${this.selectedDate.getFullYear()}-${this.selectedDate.getMonth() + 1}-${this.selectedDate.getDate()}`)
          .fontColor('#4A90E2')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
      .onClick(() => {
        // 唤起系统日期选择器
        DatePickerDialog.show({
          start: new Date("2000-1-1"),
          end: new Date("2100-12-31"),
          selected: this.selectedDate,
          onAccept: (value: DatePickerResult) => {
            this.selectedDate = new Date(value.year, value.month, value.day);
          }
        })
      })

      // 5. 底部操作按钮
      Row({ space: 15 }) {
        Button('取消')
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .fontColor('#999999')
          .onClick(() => {
            this.onCancel();
            if (this.controller) {
              this.controller.close();
            }
          })

        Button('保存')
          .layoutWeight(1)
          .backgroundColor('#333333')
          .onClick(() => {
            // 简单的表单校验
            if (!this.inputTitle.trim()) {
              // 可以添加Toast提示
              return;
            }

            // 构造更新后的数据并回调给父组件
            const updatedItem = new RecordItem(
              this.item?.id || Date.now().toString(),
              this.inputTitle.trim(),
              this.currentType,
              this.selectedDate,
              this.currentType === RecordType.ASSET ? parseFloat(this.inputPrice) || 0 : undefined
            );
            this.onConfirm(updatedItem);
            if (this.controller) {
              this.controller.close();
            }
          })
      }
      .margin({ top: 10 })
    }
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}