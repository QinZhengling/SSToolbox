// ==========================================
// 数据模型与接口定义
// ==========================================
enum RecordType {
  COUNTDOWN = 'COUNTDOWN',
  ASSET = 'ASSET'
}

enum Season {
  SPRING = 'SPRING',
  SUMMER = 'SUMMER',
  AUTUMN = 'AUTUMN',
  WINTER = 'WINTER'
}

interface SeasonTheme {
  name: string;
  emoji: string;
  background: string;
  surface: string;
  textPrimary: string;
  textSecondary: string;
  textDisabled: string;
  textOnAccent: string;
  primary: string;
  primaryLight: string;
  accentCountdown: string;
  accentAsset: string;
  border: string;
  shadowColor: string;
  inputBg: string;
  inputBorder1: string;
  inputBorder2: string;
  inputCaret: string;
  inputPlaceholder: string;
  inputText: string;
  dialogBg: string;
  dialogShadowDark: string;
  dialogShadowLight: string;
  swipeEdit: string;
  swipeDelete: string;
  headerBg: string;
  addButtonBg: string;
  listBg: string;
  barCountdown: string;
  barAsset: string;
  scrimColor: string;
}

interface BorderRadiusOptions {
  topLeft?: number;
  topRight?: number;
  bottomLeft?: number;
  bottomRight?: number;
}

const SPRING_THEME: SeasonTheme = {
  name: '春', emoji: '🌸',
  background: '#FEF6F4', surface: '#FFFBFA',
  textPrimary: '#5C1F1F', textSecondary: '#A0636A', textDisabled: '#C9A5AA', textOnAccent: '#FFFBFA',
  primary: '#B73736', primaryLight: '#EBC9C0',
  accentCountdown: '#D48392', accentAsset: '#CFAA7D',
  border: '#EBC9C0', shadowColor: 'rgba(183,55,54,0.10)',
  inputBg: '#3D1515', inputBorder1: '#D48392', inputBorder2: '#B73736',
  inputCaret: '#EBC9C0', inputPlaceholder: '#A06070', inputText: '#FBFFFF',
  dialogBg: '#FEF6F4', dialogShadowDark: 'rgba(92,31,31,0.18)', dialogShadowLight: 'rgba(212,131,145,0.20)',
  swipeEdit: '#D48392', swipeDelete: '#B73736',
  headerBg: '#FEF6F4', addButtonBg: '#B73736', listBg: '#F5EAE7',
  barCountdown: '#D48392', barAsset: '#CFAA7D',
  scrimColor: 'rgba(92,31,31,0.30)',
};

const SUMMER_THEME: SeasonTheme = {
  name: '夏', emoji: '🌊',
  background: '#F0FAFF', surface: '#FFFFFF',
  textPrimary: '#0A3D62', textSecondary: '#2980B9', textDisabled: '#A3C8E0', textOnAccent: '#FFFFFF',
  primary: '#0E6DB5', primaryLight: '#C8E8FA',
  accentCountdown: '#00B4D8', accentAsset: '#F77F00',
  border: '#B3DDF5', shadowColor: 'rgba(14,109,181,0.10)',
  inputBg: '#011F3F', inputBorder1: '#00B4D8', inputBorder2: '#0E6DB5',
  inputCaret: '#90E0EF', inputPlaceholder: '#4A90C4', inputText: '#E0F4FB',
  dialogBg: '#EDF7FF', dialogShadowDark: 'rgba(10,61,98,0.18)', dialogShadowLight: 'rgba(0,180,216,0.20)',
  swipeEdit: '#00B4D8', swipeDelete: '#E63946',
  headerBg: '#F0FAFF', addButtonBg: '#0E6DB5', listBg: '#E6F5FC',
  barCountdown: '#00B4D8', barAsset: '#F77F00',
  scrimColor: 'rgba(10,61,98,0.30)',
};

const AUTUMN_THEME: SeasonTheme = {
  name: '秋', emoji: '🍂',
  background: '#FDF6EE', surface: '#FFFCF8',
  textPrimary: '#3D1F00', textSecondary: '#8B5E2C', textDisabled: '#C4A47C', textOnAccent: '#FFFCF8',
  primary: '#C45C00', primaryLight: '#F5D9B0',
  accentCountdown: '#E07B39', accentAsset: '#8B3A3A',
  border: '#E8C99A', shadowColor: 'rgba(61,31,0,0.10)',
  inputBg: '#1E0D00', inputBorder1: '#E07B39', inputBorder2: '#C45C00',
  inputCaret: '#F5D9B0', inputPlaceholder: '#9C6A35', inputText: '#FDF6EE',
  dialogBg: '#FDF6EE', dialogShadowDark: 'rgba(61,31,0,0.18)', dialogShadowLight: 'rgba(224,123,57,0.20)',
  swipeEdit: '#E07B39', swipeDelete: '#8B3A3A',
  headerBg: '#FDF6EE', addButtonBg: '#C45C00', listBg: '#F2E6D5',
  barCountdown: '#E07B39', barAsset: '#8B3A3A',
  scrimColor: 'rgba(61,31,0,0.30)',
};

const WINTER_THEME: SeasonTheme = {
  name: '冬', emoji: '❄️',
  background: '#F2F6FA', surface: '#FFFFFF',
  textPrimary: '#1A2A3A', textSecondary: '#4A6480', textDisabled: '#9BAFC4', textOnAccent: '#FFFFFF',
  primary: '#2D5F8A', primaryLight: '#CCE0F0',
  accentCountdown: '#4A90C4', accentAsset: '#607D8B',
  border: '#C8D8E8', shadowColor: 'rgba(26,42,58,0.10)',
  inputBg: '#0A1520', inputBorder1: '#4A90C4', inputBorder2: '#2D5F8A',
  inputCaret: '#CCE0F0', inputPlaceholder: '#5A7A94', inputText: '#E4EDF5',
  dialogBg: '#F2F6FA', dialogShadowDark: 'rgba(26,42,58,0.18)', dialogShadowLight: 'rgba(74,144,196,0.20)',
  swipeEdit: '#4A90C4', swipeDelete: '#C0392B',
  headerBg: '#F2F6FA', addButtonBg: '#1A2A3A', listBg: '#E8EFF6',
  barCountdown: '#4A90C4', barAsset: '#607D8B',
  scrimColor: 'rgba(26,42,58,0.30)',
};

const ALL_THEMES: Record<Season, SeasonTheme> = {
  [Season.SPRING]: SPRING_THEME,
  [Season.SUMMER]: SUMMER_THEME,
  [Season.AUTUMN]: AUTUMN_THEME,
  [Season.WINTER]: WINTER_THEME,
};

class RecordItem {
  id: string;
  title: string;
  type: RecordType;
  date: Date;
  price?: number;
  constructor(id: string, title: string, type: RecordType, date: Date, price?: number) {
    this.id = id; this.title = title; this.type = type; this.date = date; this.price = price;
  }
}

class RecordItemWithDays extends RecordItem {
  days: number;
  constructor(recordItem: RecordItem, days: number) {
    super(recordItem.id, recordItem.title, recordItem.type, recordItem.date, recordItem.price);
    this.days = days;
  }
}

// ==========================================
// AnimatedInput
// ==========================================
@Component
export struct AnimatedInput {
  @Prop placeholder: string = 'Search...';
  @Prop text: string = '';
  @Prop inputType: InputType = InputType.Normal;
  @Prop themeBg: string = '#3D1515';
  @Prop themeColor1: string = '#D48392';
  @Prop themeColor2: string = '#B73736';
  @Prop themeCaret: string = '#EBC9C0';
  @Prop themePlaceholder: string = '#A06070';
  @Prop themeText: string = '#FBFFFF';
  onChangeCallback: (value: string) => void = () => {};
  @State rotateAngle: number = 0;

  aboutToAppear() { setTimeout(() => { this.rotateAngle = 360; }, 50); }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Stack() {
        Stack().width(800).height(800)
          .position({ left: '50%', top: '50%' }).markAnchor({ x: 400, y: 400 })
          .sweepGradient({ center: ['50%', '50%'], start: 0, end: 360, colors: [
            ['rgba(0,0,0,0)', 0.0], [this.themeColor1, 0.05], ['rgba(0,0,0,0)', 0.38],
            ['rgba(0,0,0,0)', 0.50], [this.themeColor2, 0.60], ['rgba(0,0,0,0)', 0.87], ['rgba(0,0,0,0)', 1.0]
          ]})
          .rotate({ angle: this.rotateAngle }).animation({ duration: 4000, curve: Curve.Linear, iterations: -1 })
      }.width('100%').height('100%').borderRadius(12).clip(true).blur(20).opacity(0.8)

      Stack() {
        Stack().width(800).height(800)
          .position({ left: '50%', top: '50%' }).markAnchor({ x: 400, y: 400 })
          .sweepGradient({ center: ['50%', '50%'], start: 0, end: 360, colors: [
            [this.themeBg, 0.0], [this.themeColor1, 0.05], [this.themeBg, 0.14],
            [this.themeBg, 0.50], [this.themeColor2, 0.60], [this.themeBg, 0.64], [this.themeBg, 1.0]
          ]})
          .rotate({ angle: this.rotateAngle }).animation({ duration: 4000, curve: Curve.Linear, iterations: -1 })
      }.width('100%').height('100%').borderRadius(12).clip(true)

      Stack() {
        TextInput({ placeholder: this.placeholder, text: this.text })
          .type(this.inputType).backgroundColor(Color.Transparent)
          .fontColor(this.themeText).placeholderColor(this.themePlaceholder).caretColor(this.themeCaret)
          .fontSize(16).width('100%').height('100%').padding({ left: 16, right: 16 })
          .onChange((v: string) => this.onChangeCallback(v))
      }.width('calc(100% - 4vp)').height('calc(100% - 4vp)').backgroundColor(this.themeBg).borderRadius(10).clip(true)
    }.width('100%').height(56).clip(false).margin({ top: 16, bottom: 16 })
  }
}

// ==========================================
// 主页面 Index（所有抽屉内嵌其中）
// ==========================================
@Entry
@Component
struct Index {
  @State topSafeAreaHeight: number = 0;
  @State openSwipeId: string = '';
  @State openSwipeSide: 'none' | 'start' | 'end' = 'none';

  @State currentSeason: Season = Season.SPRING;
  @State currentTheme: SeasonTheme = SPRING_THEME;

  @State recordList: RecordItem[] = [];
  @State processedList: RecordItemWithDays[] = [];

  @State pressedItemId: string = '';

  // ── 抽屉状态 ──────────────────────────────
  // 添加抽屉
  @State showAddDrawer: boolean = false;
  @State addDrawerOffset: number = 800;
  @State addDrawerOpacity: number = 0;
  @State addType: RecordType = RecordType.COUNTDOWN;
  @State addTitle: string = '';
  @State addPrice: string = '';
  @State addDate: Date = new Date();
  @State addCardScale: number = 1.0;

  // 编辑抽屉
  @State showEditDrawer: boolean = false;
  @State editDrawerOffset: number = 800;
  @State editDrawerOpacity: number = 0;
  @State editingItem: RecordItemWithDays | null = null;
  @State editType: RecordType = RecordType.COUNTDOWN;
  @State editTitle: string = '';
  @State editPrice: string = '';
  @State editDate: Date = new Date();

  // 删除确认抽屉
  @State showDeleteDrawer: boolean = false;
  @State deleteDrawerOffset: number = 800;
  @State deleteDrawerOpacity: number = 0;
  @State itemToDelete: RecordItemWithDays | null = null;

  // ── 工具方法 ──────────────────────────────
  switchSeason(s: Season): void { this.currentSeason = s; this.currentTheme = ALL_THEMES[s]; }

  getDaysDiff(targetDate: Date, isAsset: boolean): number {
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const target = new Date(targetDate); target.setHours(0, 0, 0, 0);
    const diffTime = target.getTime() - today.getTime();
    let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    if (isAsset) { diffDays = Math.abs(diffDays); return diffDays === 0 ? 1 : diffDays; }
    return diffDays;
  }

  getDailyPrice(price: number, days: number): string {
    if (days <= 0) return '0.00';
    const daily = price / days;
    return isNaN(daily) ? '0.00' : daily.toFixed(2);
  }

  formatDate(date: Date): string {
    return `${date.getFullYear()}-${(date.getMonth()+1).toString().padStart(2,'0')}-${date.getDate().toString().padStart(2,'0')}`;
  }

  processData(): void {
    this.processedList = this.recordList.map(item => new RecordItemWithDays(item, this.getDaysDiff(item.date, item.type === RecordType.ASSET)));
  }

  aboutToAppear() {
    this.recordList = [
      new RecordItem('1', 'MacBook Pro', RecordType.ASSET, new Date('2023-10-01'), 14999),
      new RecordItem('2', '女朋友生日', RecordType.COUNTDOWN, new Date('2026-05-20')),
      new RecordItem('3', '降噪耳机', RecordType.ASSET, new Date('2024-01-15'), 1999),
      new RecordItem('4', '发工资', RecordType.COUNTDOWN, new Date('2026-03-10'))
    ];
    this.processData();
    this.topSafeAreaHeight = 48;
  }

  deleteRecord(itemId: string): void {
    const index = this.recordList.findIndex(item => item.id === itemId);
    if (index !== -1) { this.recordList.splice(index, 1); this.processData(); }
  }

  // ── 抽屉开关 ──────────────────────────────
  openAddDrawer(): void {
    this.addTitle = ''; this.addPrice = ''; this.addDate = new Date(); this.addType = RecordType.COUNTDOWN;
    this.addDrawerOffset = 800; this.addDrawerOpacity = 0; this.showAddDrawer = true;
    setTimeout(() => { this.addDrawerOffset = 0; this.addDrawerOpacity = 1; }, 20);
  }
  closeAddDrawer(): void {
    this.addDrawerOffset = 800; this.addDrawerOpacity = 0;
    setTimeout(() => { this.showAddDrawer = false; }, 350);
  }
  confirmAdd(): void {
    if (!this.addTitle.trim()) return;
    const newItem = new RecordItem(Date.now().toString(), this.addTitle.trim(), this.addType, this.addDate,
      this.addType === RecordType.ASSET ? parseFloat(this.addPrice) || 0 : undefined);
    this.recordList.push(newItem); this.processData();
    this.closeAddDrawer();
  }

  openEditDrawer(item: RecordItemWithDays): void {
    this.editingItem = item; this.editType = item.type; this.editTitle = item.title;
    this.editPrice = item.price?.toString() || ''; this.editDate = item.date;
    this.editDrawerOffset = 800; this.editDrawerOpacity = 0; this.showEditDrawer = true;
    setTimeout(() => { this.editDrawerOffset = 0; this.editDrawerOpacity = 1; }, 20);
  }
  closeEditDrawer(): void {
    this.editDrawerOffset = 800; this.editDrawerOpacity = 0;
    setTimeout(() => { this.showEditDrawer = false; this.editingItem = null; }, 350);
  }
  confirmEdit(): void {
    if (!this.editTitle.trim() || !this.editingItem) return;
    const updated = new RecordItem(this.editingItem.id, this.editTitle.trim(), this.editType, this.editDate,
      this.editType === RecordType.ASSET ? parseFloat(this.editPrice) || 0 : undefined);
    const idx = this.recordList.findIndex(r => r.id === this.editingItem!.id);
    if (idx !== -1) { this.recordList[idx] = updated; this.processData(); }
    this.closeEditDrawer();
  }

  openDeleteDrawer(item: RecordItemWithDays): void {
    this.itemToDelete = item;
    this.deleteDrawerOffset = 800; this.deleteDrawerOpacity = 0; this.showDeleteDrawer = true;
    setTimeout(() => { this.deleteDrawerOffset = 0; this.deleteDrawerOpacity = 1; }, 20);
  }
  closeDeleteDrawer(): void {
    this.deleteDrawerOffset = 800; this.deleteDrawerOpacity = 0;
    setTimeout(() => { this.showDeleteDrawer = false; this.itemToDelete = null; }, 350);
  }
  confirmDelete(): void {
    if (this.itemToDelete) { this.deleteRecord(this.itemToDelete.id); }
    this.closeDeleteDrawer();
  }

  // ── 圆角计算 ──────────────────────────────
  private calcRadius(index: number, item: RecordItemWithDays, swipingLeft: boolean, swipingRight: boolean): BorderRadiusOptions {
    let tl = 16, tr = 16, bl = 16, br = 16;
    if (index === 0) { tl += 4; tr += 4; }
    if (index === this.processedList.length - 1) { bl += 4; br += 4; }
    if (this.openSwipeId === item.id && this.openSwipeSide === 'start') { tl = 0; bl = 0; }
    if (this.openSwipeId === item.id && this.openSwipeSide === 'end') { tr = 0; br = 0; }
    const tr2 = item.type === RecordType.ASSET ? 2 : 0;
    tl += tr2; bl += tr2;
    if (this.pressedItemId === item.id) { tl += 2; tr += 2; bl += 2; br += 2; }
    const lr = swipingRight ? 16 : 0;
    const rr = swipingLeft ? 16 : 0;
    return { topLeft: Math.max(0, tl-lr), topRight: Math.max(0, tr-rr), bottomLeft: Math.max(0, bl-lr), bottomRight: Math.max(0, br-rr) };
  }

  // ── Builders ──────────────────────────────
  @Builder EditSwipeAction(item: RecordItemWithDays) {
    Row() {
      Button('编辑').width(76).height('100%').backgroundColor(this.currentTheme.swipeEdit)
        .fontColor(Color.White).fontWeight(FontWeight.Bolder).fontSize(16)
        .type(ButtonType.Normal).borderRadius({ topLeft: 16, bottomLeft: 16 })
        .onClick(() => { this.openEditDrawer(item); })
    }.height(96)
  }

  @Builder DeleteSwipeAction(item: RecordItemWithDays) {
    Row() {
      Button('删除').width(76).height('100%').backgroundColor(this.currentTheme.swipeDelete)
        .fontColor(Color.White).fontWeight(FontWeight.Bolder).fontSize(16)
        .type(ButtonType.Normal).borderRadius({ topRight: 16, bottomRight: 16 })
        .onClick(() => { this.openDeleteDrawer(item); })
    }.height(96)
  }

  @Builder ItemCard(item: RecordItemWithDays, index: number) {
    Row() {
      Column() { Blank() }
      .width(6).height(80)
      .backgroundColor(item.type === RecordType.ASSET ? this.currentTheme.barAsset : this.currentTheme.barCountdown)
      .borderRadius({
        topLeft: this.calcRadius(index, item, this.openSwipeId===item.id&&this.openSwipeSide==='end', this.openSwipeId===item.id&&this.openSwipeSide==='start').topLeft,
        bottomLeft: this.calcRadius(index, item, this.openSwipeId===item.id&&this.openSwipeSide==='end', this.openSwipeId===item.id&&this.openSwipeSide==='start').bottomLeft,
        topRight: 0, bottomRight: 0
      })
      .margin({ right: 16 }).animation({ duration: 100, curve: Curve.EaseOut })

      Column() {
        Text(item.title).fontSize(22).fontWeight(FontWeight.Bold).fontColor(this.currentTheme.textPrimary)
          .margin({ bottom: 6 }).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(item.type===RecordType.ASSET ? `购买日: ${this.formatDate(item.date)}` : `目标日: ${this.formatDate(item.date)}`)
          .fontSize(12).fontColor(this.currentTheme.textDisabled).maxLines(1)
      }.alignItems(HorizontalAlign.Start).layoutWeight(1).height(80).justifyContent(FlexAlign.Center)

      Column({ space: 2 }) {
        Row() {
          Text(item.type===RecordType.ASSET ? `¥ ${this.getDailyPrice(item.price??0, item.days)}` : `${Math.abs(item.days)}`)
            .fontSize(item.type===RecordType.ASSET ? 24 : 32).fontWeight(FontWeight.Bold)
            .fontColor(item.type===RecordType.ASSET ? this.currentTheme.accentAsset : this.currentTheme.accentCountdown).maxLines(1)
          Text(item.type===RecordType.ASSET ? ' /天' : (item.days>=0 ? '天后' : '天前'))
            .fontSize(item.type===RecordType.ASSET ? 14 : 11)
            .fontColor(item.type===RecordType.ASSET ? this.currentTheme.accentAsset : this.currentTheme.textDisabled)
        }
        Text(item.type===RecordType.ASSET ? `已用 ${item.days} 天` : '')
          .fontSize(11).fontColor(this.currentTheme.textDisabled).margin({ top: 2 })
      }.alignItems(HorizontalAlign.End).height(80).justifyContent(FlexAlign.Center)
    }
    .width('100%').height(96).padding({ left: 16, right: 20 })
    .backgroundColor(this.currentTheme.surface)
    .borderRadius(this.calcRadius(index, item, this.openSwipeId===item.id&&this.openSwipeSide==='end', this.openSwipeId===item.id&&this.openSwipeSide==='start'))
    .shadow({ radius: this.pressedItemId===item.id ? 12 : 8, color: this.currentTheme.shadowColor, offsetY: this.pressedItemId===item.id ? 6 : 4 })
    .animation({ duration: 100, curve: Curve.EaseOut })
    .onTouch((event) => { this.pressedItemId = event.type===TouchType.Down ? item.id : ''; })
  }

  // ── 抽屉内容 Builders ─────────────────────

  // 复用：类型选择行
  @Builder TypeSelector(selectedType: RecordType, onCountdown: () => void, onAsset: () => void) {
    Row({ space: 16 }) {
      Column({ space: 10 }) {
        Text('🎯').fontSize(26)
        Text('倒数日').fontSize(15).fontWeight(FontWeight.Medium)
          .fontColor(selectedType===RecordType.COUNTDOWN ? this.currentTheme.textOnAccent : this.currentTheme.textPrimary)
      }
      .layoutWeight(1).padding(18)
      .backgroundColor(selectedType===RecordType.COUNTDOWN ? this.currentTheme.accentCountdown : this.currentTheme.surface)
      .borderRadius(14).border({ width: selectedType===RecordType.COUNTDOWN ? 0 : 1.5, color: this.currentTheme.border })
      .onClick(onCountdown)

      Column({ space: 10 }) {
        Text('💰').fontSize(26)
        Text('资产').fontSize(15).fontWeight(FontWeight.Medium)
          .fontColor(selectedType===RecordType.ASSET ? this.currentTheme.textOnAccent : this.currentTheme.textPrimary)
      }
      .layoutWeight(1).padding(18)
      .backgroundColor(selectedType===RecordType.ASSET ? this.currentTheme.accentAsset : this.currentTheme.surface)
      .borderRadius(14).border({ width: selectedType===RecordType.ASSET ? 0 : 1.5, color: this.currentTheme.border })
      .onClick(onAsset)
    }.width('100%').height(90)
  }

  // 复用：日期选择行
  @Builder DateRow(label: string, date: Date, onPick: () => void) {
    Row() {
      Text('📅').fontSize(18).margin({ right: 14 })
      Column({ space: 3 }) {
        Text(label).fontSize(11).fontColor(this.currentTheme.textSecondary)
        Text(`${date.getFullYear()}年${date.getMonth()+1}月${date.getDate()}日`)
          .fontSize(15).fontColor(this.currentTheme.textPrimary).fontWeight(FontWeight.Medium)
      }.alignItems(HorizontalAlign.Start).layoutWeight(1)
      Text('修改').fontSize(12).fontColor(this.currentTheme.primary).fontWeight(FontWeight.Medium)
        .padding({ left: 10, right: 10, top: 5, bottom: 5 }).backgroundColor(this.currentTheme.primaryLight).borderRadius(12)
    }
    .width('100%').height(58).padding({ left: 14, right: 14 })
    .backgroundColor(this.currentTheme.surface).borderRadius(12)
    .border({ width: 1.5, color: this.currentTheme.border })
    .onClick(onPick)
  }

  // 复用：抽屉把手 + 标题栏
  @Builder DrawerHandle(title: string, subtitle: string) {
    Column({ space: 0 }) {
      // 把手条
      Row()
        .width(40).height(4).borderRadius(2)
        .backgroundColor(this.currentTheme.border)
        .margin({ top: 12, bottom: 20 })
      Row() {
        Column({ space: 4 }) {
          Text(title).fontSize(20).fontWeight(FontWeight.Bold).fontColor(this.currentTheme.textPrimary)
          Text(subtitle).fontSize(13).fontColor(this.currentTheme.textSecondary)
        }.alignItems(HorizontalAlign.Start).layoutWeight(1)
      }.width('100%').padding({ left: 24, right: 24 }).margin({ bottom: 20 })
    }.width('100%').alignItems(HorizontalAlign.Center)
  }

  // 复用：底部确认/取消按钮行
  @Builder DrawerActions(confirmLabel: string, confirmColor: string, onConfirm: () => void, onCancel: () => void) {
    Row({ space: 12 }) {
      Button('取消')
        .layoutWeight(1).height(50)
        .backgroundColor(this.currentTheme.surface)
        .fontColor(this.currentTheme.textSecondary).fontSize(16).fontWeight(FontWeight.Medium)
        .borderRadius(14).border({ width: 1.5, color: this.currentTheme.border })
        .type(ButtonType.Normal)
        .onClick(onCancel)
      Button(confirmLabel)
        .layoutWeight(1).height(50)
        .backgroundColor(confirmColor)
        .fontColor(this.currentTheme.textOnAccent).fontSize(16).fontWeight(FontWeight.Bold)
        .borderRadius(14).type(ButtonType.Normal)
        .onClick(onConfirm)
    }.width('100%').padding({ left: 24, right: 24, top: 16, bottom: 32 })
  }

  // 添加抽屉
  @Builder AddDrawer() {
    Column() {
      this.DrawerHandle('添加新记录', '记录生活中的重要时刻')

      Scroll() {
        Column({ space: 20 }) {
          // 类型选择
          Column({ space: 10 }) {
            Text('记录类型').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
            this.TypeSelector(this.addType, () => { this.addType = RecordType.COUNTDOWN; }, () => { this.addType = RecordType.ASSET; })
          }.width('100%')

          // 标题
          Column({ space: 8 }) {
            Text('记录标题').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
            AnimatedInput({
              placeholder: this.addType===RecordType.COUNTDOWN ? '例如：女朋友生日...' : '例如：MacBook Pro...',
              text: this.addTitle,
              themeBg: this.currentTheme.inputBg, themeColor1: this.currentTheme.inputBorder1, themeColor2: this.currentTheme.inputBorder2,
              themeCaret: this.currentTheme.inputCaret, themePlaceholder: this.currentTheme.inputPlaceholder, themeText: this.currentTheme.inputText,
              onChangeCallback: (v: string) => { this.addTitle = v; }
            })
          }.width('100%')

          // 价格（仅资产）
          if (this.addType === RecordType.ASSET) {
            Column({ space: 8 }) {
              Text('购买价格 (¥)').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
              AnimatedInput({
                placeholder: '0.00', text: this.addPrice, inputType: InputType.Number,
                themeBg: this.currentTheme.inputBg, themeColor1: this.currentTheme.inputBorder1, themeColor2: this.currentTheme.inputBorder2,
                themeCaret: this.currentTheme.inputCaret, themePlaceholder: this.currentTheme.inputPlaceholder, themeText: this.currentTheme.inputText,
                onChangeCallback: (v: string) => { this.addPrice = v; }
              })
            }.width('100%')
          }

          // 日期
          Column({ space: 8 }) {
            Text(this.addType===RecordType.ASSET ? '购买日期' : '目标日期').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
            this.DateRow(this.addType===RecordType.ASSET ? '购买日期' : '目标日期', this.addDate, () => {
              DatePickerDialog.show({ start: new Date('2000-1-1'), end: new Date('2100-12-31'), selected: this.addDate,
                onAccept: (v: DatePickerResult) => { this.addDate = new Date(v.year, v.month, v.day); } })
            })
          }.width('100%')
        }.padding({ left: 24, right: 24, bottom: 8 })
      }.scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off).edgeEffect(EdgeEffect.None).layoutWeight(1)

      this.DrawerActions('保存记录', this.currentTheme.primary, () => { this.confirmAdd(); }, () => { this.closeAddDrawer(); })
    }
    .width('100%')
    .backgroundColor(this.currentTheme.dialogBg)
    .borderRadius({ topLeft: 28, topRight: 28, bottomLeft: 0, bottomRight: 0 })
    .shadow({ radius: 40, color: this.currentTheme.dialogShadowDark, offsetY: -4 })
    .constraintSize({ maxHeight: '88%' })
  }

  // 编辑抽屉
  @Builder EditDrawer() {
    Column() {
      this.DrawerHandle('编辑记录', '修改记录的信息')

      Scroll() {
        Column({ space: 20 }) {
          Column({ space: 10 }) {
            Text('记录类型').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
            this.TypeSelector(this.editType, () => { this.editType = RecordType.COUNTDOWN; }, () => { this.editType = RecordType.ASSET; })
          }.width('100%')

          Column({ space: 8 }) {
            Text('记录标题').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
            AnimatedInput({
              placeholder: this.editType===RecordType.COUNTDOWN ? '例如：女朋友生日...' : '例如：MacBook Pro...',
              text: this.editTitle,
              themeBg: this.currentTheme.inputBg, themeColor1: this.currentTheme.inputBorder1, themeColor2: this.currentTheme.inputBorder2,
              themeCaret: this.currentTheme.inputCaret, themePlaceholder: this.currentTheme.inputPlaceholder, themeText: this.currentTheme.inputText,
              onChangeCallback: (v: string) => { this.editTitle = v; }
            })
          }.width('100%')

          if (this.editType === RecordType.ASSET) {
            Column({ space: 8 }) {
              Text('购买价格 (¥)').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
              AnimatedInput({
                placeholder: '0.00', text: this.editPrice, inputType: InputType.Number,
                themeBg: this.currentTheme.inputBg, themeColor1: this.currentTheme.inputBorder1, themeColor2: this.currentTheme.inputBorder2,
                themeCaret: this.currentTheme.inputCaret, themePlaceholder: this.currentTheme.inputPlaceholder, themeText: this.currentTheme.inputText,
                onChangeCallback: (v: string) => { this.editPrice = v; }
              })
            }.width('100%')
          }

          Column({ space: 8 }) {
            Text(this.editType===RecordType.ASSET ? '购买日期' : '目标日期').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.currentTheme.textSecondary).alignSelf(ItemAlign.Start)
            this.DateRow(this.editType===RecordType.ASSET ? '购买日期' : '目标日期', this.editDate, () => {
              DatePickerDialog.show({ start: new Date('2000-1-1'), end: new Date('2100-12-31'), selected: this.editDate,
                onAccept: (v: DatePickerResult) => { this.editDate = new Date(v.year, v.month, v.day); } })
            })
          }.width('100%')
        }.padding({ left: 24, right: 24, bottom: 8 })
      }.scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off).edgeEffect(EdgeEffect.None).layoutWeight(1)

      this.DrawerActions('保存修改', this.currentTheme.primary, () => { this.confirmEdit(); }, () => { this.closeEditDrawer(); })
    }
    .width('100%')
    .backgroundColor(this.currentTheme.dialogBg)
    .borderRadius({ topLeft: 28, topRight: 28, bottomLeft: 0, bottomRight: 0 })
    .shadow({ radius: 40, color: this.currentTheme.dialogShadowDark, offsetY: -4 })
    .constraintSize({ maxHeight: '88%' })
  }

  // 删除确认抽屉
  @Builder DeleteDrawer() {
    Column({ space: 0 }) {
      this.DrawerHandle('确认删除', '此操作无法撤销')

      Column({ space: 16 }) {
        // 被删除项预览卡
        Row() {
          Column() { Blank() }
          .width(5).height(56)
          .backgroundColor(this.itemToDelete?.type===RecordType.ASSET ? this.currentTheme.barAsset : this.currentTheme.barCountdown)
          .borderRadius(3).margin({ right: 14 })
          Column({ space: 4 }) {
            Text(this.itemToDelete?.title || '').fontSize(18).fontWeight(FontWeight.Bold).fontColor(this.currentTheme.textPrimary).maxLines(1)
            Text(this.itemToDelete?.type===RecordType.ASSET ? '资产记录' : '倒数日记录')
              .fontSize(12).fontColor(this.currentTheme.textSecondary)
          }.alignItems(HorizontalAlign.Start).layoutWeight(1)
        }
        .width('100%').height(72).padding({ left: 16, right: 16 })
        .backgroundColor(this.currentTheme.surface).borderRadius(14)
        .border({ width: 1.5, color: this.currentTheme.border })
      }.width('100%').padding({ left: 24, right: 24 })

      this.DrawerActions('确认删除', this.currentTheme.swipeDelete, () => { this.confirmDelete(); }, () => { this.closeDeleteDrawer(); })
    }
    .width('100%')
    .backgroundColor(this.currentTheme.dialogBg)
    .borderRadius({ topLeft: 28, topRight: 28, bottomLeft: 0, bottomRight: 0 })
    .shadow({ radius: 40, color: this.currentTheme.dialogShadowDark, offsetY: -4 })
  }

  // ── 主界面 build ──────────────────────────
  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // ── 主内容层 ──
      Column() {
        Blank().height(this.topSafeAreaHeight)

        // Header
        Row() {
          Column({ space: 2 }) {
            Text('我的时价').fontSize(32).fontWeight(FontWeight.Bold).fontColor(this.currentTheme.textPrimary)
            Text('记录生活中的美好时光').fontSize(14).fontColor(this.currentTheme.textSecondary)
          }.alignItems(HorizontalAlign.Start).layoutWeight(1)
          Button('+').fontSize(28).width(56).height(56)
            .backgroundColor(this.currentTheme.addButtonBg).fontColor(this.currentTheme.textOnAccent)
            .type(ButtonType.Circle).shadow({ radius: 8, color: this.currentTheme.shadowColor, offsetY: 4 })
            .onClick(() => { this.openAddDrawer(); })
        }.width('100%').padding({ top: 24, bottom: 16, left: 24, right: 24 }).backgroundColor(this.currentTheme.headerBg)

        // 四季切换栏
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text(SPRING_THEME.emoji).fontSize(20)
            Text(SPRING_THEME.name).fontSize(12)
              .fontWeight(this.currentSeason===Season.SPRING ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.currentSeason===Season.SPRING ? SPRING_THEME.primary : '#AAAAAA')
          }.layoutWeight(1).padding({ top: 8, bottom: 10 })
          .backgroundColor(this.currentSeason===Season.SPRING ? SPRING_THEME.primaryLight : Color.Transparent)
          .borderRadius(20).animation({ duration: 250, curve: Curve.EaseOut })
          .onClick(() => { this.switchSeason(Season.SPRING); })

          Column({ space: 2 }) {
            Text(SUMMER_THEME.emoji).fontSize(20)
            Text(SUMMER_THEME.name).fontSize(12)
              .fontWeight(this.currentSeason===Season.SUMMER ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.currentSeason===Season.SUMMER ? SUMMER_THEME.primary : '#AAAAAA')
          }.layoutWeight(1).padding({ top: 8, bottom: 10 })
          .backgroundColor(this.currentSeason===Season.SUMMER ? SUMMER_THEME.primaryLight : Color.Transparent)
          .borderRadius(20).animation({ duration: 250, curve: Curve.EaseOut })
          .onClick(() => { this.switchSeason(Season.SUMMER); })

          Column({ space: 2 }) {
            Text(AUTUMN_THEME.emoji).fontSize(20)
            Text(AUTUMN_THEME.name).fontSize(12)
              .fontWeight(this.currentSeason===Season.AUTUMN ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.currentSeason===Season.AUTUMN ? AUTUMN_THEME.primary : '#AAAAAA')
          }.layoutWeight(1).padding({ top: 8, bottom: 10 })
          .backgroundColor(this.currentSeason===Season.AUTUMN ? AUTUMN_THEME.primaryLight : Color.Transparent)
          .borderRadius(20).animation({ duration: 250, curve: Curve.EaseOut })
          .onClick(() => { this.switchSeason(Season.AUTUMN); })

          Column({ space: 2 }) {
            Text(WINTER_THEME.emoji).fontSize(20)
            Text(WINTER_THEME.name).fontSize(12)
              .fontWeight(this.currentSeason===Season.WINTER ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.currentSeason===Season.WINTER ? WINTER_THEME.primary : '#AAAAAA')
          }.layoutWeight(1).padding({ top: 8, bottom: 10 })
          .backgroundColor(this.currentSeason===Season.WINTER ? WINTER_THEME.primaryLight : Color.Transparent)
          .borderRadius(20).animation({ duration: 250, curve: Curve.EaseOut })
          .onClick(() => { this.switchSeason(Season.WINTER); })
        }.width('100%').padding({ left: 12, right: 12, bottom: 12 }).backgroundColor(this.currentTheme.headerBg)

        // 列表
        List({ space: 12 }) {
          ForEach(this.processedList, (item: RecordItemWithDays, index: number) => {
            ListItem() { this.ItemCard(item, index) }
            .swipeAction({
              start: { builder: () => { this.EditSwipeAction(item) },
                onStateChange: (state: SwipeActionState) => {
                  if (state===SwipeActionState.EXPANDED) { this.openSwipeId=item.id; this.openSwipeSide='start'; }
                  else if (state===SwipeActionState.COLLAPSED && this.openSwipeId===item.id) { this.openSwipeSide='none'; }
                }
              },
              end: { builder: () => { this.DeleteSwipeAction(item) }, actionAreaDistance: 80,
                onAction: () => { this.openDeleteDrawer(item); },
                onStateChange: (state: SwipeActionState) => {
                  if (state===SwipeActionState.EXPANDED) { this.openSwipeId=item.id; this.openSwipeSide='end'; }
                  else if (state===SwipeActionState.COLLAPSED && this.openSwipeId===item.id) { this.openSwipeSide='none'; }
                }
              },
              edgeEffect: SwipeEdgeEffect.Spring
            })
          }, (item: RecordItemWithDays) => item.id)
        }.width('100%').flexGrow(1).padding({ left: 16, right: 16, top: 8 }).backgroundColor(this.currentTheme.listBg)
      }
      .width('100%').height('100%').backgroundColor(this.currentTheme.listBg)
      .animation({ duration: 350, curve: Curve.EaseInOut })

      // ── 蒙层 + 抽屉层（叠在主内容之上）──

      // 添加蒙层
      if (this.showAddDrawer) {
        Column()
          .width('100%').height('100%')
          .backgroundColor(this.currentTheme.scrimColor)
          .opacity(this.addDrawerOpacity)
          .animation({ duration: 320, curve: Curve.EaseOut })
          .onClick(() => { this.closeAddDrawer(); })
          .position({ x: 0, y: 0 })
      }
      // 添加抽屉
      if (this.showAddDrawer) {
        Column() { this.AddDrawer() }
        .width('100%')
        .translate({ y: this.addDrawerOffset })
        .opacity(this.addDrawerOpacity)
        .animation({ duration: 350, curve: Curve.FastOutSlowIn })
      }

      // 编辑蒙层
      if (this.showEditDrawer) {
        Column()
          .width('100%').height('100%')
          .backgroundColor(this.currentTheme.scrimColor)
          .opacity(this.editDrawerOpacity)
          .animation({ duration: 320, curve: Curve.EaseOut })
          .onClick(() => { this.closeEditDrawer(); })
          .position({ x: 0, y: 0 })
      }
      // 编辑抽屉
      if (this.showEditDrawer) {
        Column() { this.EditDrawer() }
        .width('100%')
        .translate({ y: this.editDrawerOffset })
        .opacity(this.editDrawerOpacity)
        .animation({ duration: 350, curve: Curve.FastOutSlowIn })
      }

      // 删除蒙层
      if (this.showDeleteDrawer) {
        Column()
          .width('100%').height('100%')
          .backgroundColor(this.currentTheme.scrimColor)
          .opacity(this.deleteDrawerOpacity)
          .animation({ duration: 320, curve: Curve.EaseOut })
          .onClick(() => { this.closeDeleteDrawer(); })
          .position({ x: 0, y: 0 })
      }
      // 删除抽屉
      if (this.showDeleteDrawer) {
        Column() { this.DeleteDrawer() }
        .width('100%')
        .translate({ y: this.deleteDrawerOffset })
        .opacity(this.deleteDrawerOpacity)
        .animation({ duration: 350, curve: Curve.FastOutSlowIn })
      }

    }.width('100%').height('100%')
  }
}
