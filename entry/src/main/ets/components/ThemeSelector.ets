/*
 * 主题选择器组件
 */

import { ThemeManager, ThemeConfig, ThemeUtils } from '../theme/AppTheme';

@Component
export struct ThemeSelector {
  @State isVisible: boolean = false;
  @State currentThemeName: string = 'spring';
  
  // 主题切换回调
  private onThemeChange?: (themeName: string) => void;
  
  // 构建主题选项
  @Builder
  ThemeOption(theme: ThemeConfig, index: number) {
    Column({ space: 8 }) {
      // 主题颜色预览
      Row() {
        // 主色调预览
        Column()
          .width(24)
          .height(24)
          .backgroundColor(theme.colors.primary)
          .borderRadius(12)
        
        // 强调色预览
        Column()
          .width(24)
          .height(24)
          .backgroundColor(theme.colors.secondary)
          .borderRadius(12)
          .margin({ left: 4 })
        
        // 辅助色预览
        Column()
          .width(24)
          .height(24)
          .backgroundColor(theme.colors.accent)
          .borderRadius(12)
          .margin({ left: 4 })
      }
      
      // 主题名称
      Text(this.getThemeDisplayName(theme.name))
        .fontSize(14)
        .fontColor(this.currentThemeName === theme.name ? theme.colors.primary : '#666666')
        .fontWeight(this.currentThemeName === theme.name ? FontWeight.Bold : FontWeight.Normal)
    }
    .width(120)
    .height(80)
    .backgroundColor(this.currentThemeName === theme.name ? theme.colors.surface : '#F5F5F5')
    .borderRadius(12)
    .border({
      width: this.currentThemeName === theme.name ? 2 : 1,
      color: this.currentThemeName === theme.name ? theme.colors.primary : '#E0E0E0'
    })
    .padding(12)
    .onClick(() => {
      this.currentThemeName = theme.name;
      ThemeManager.setTheme(theme.name);
      if (this.onThemeChange) {
        this.onThemeChange(theme.name);
      }
      this.isVisible = false;
    })
  }
  
  // 获取主题显示名称
  private getThemeDisplayName(themeName: string): string {
    switch (themeName) {
      case 'spring': return '春之巴黎';
      case 'summer': return '夏日海洋';
      case 'autumn': return '金色秋天';
      case 'winter': return '冰雪冬日';
      default: return themeName;
    }
  }
  
  build() {
    const theme = ThemeManager.getCurrentTheme();
    
    Column() {
      // 主题切换按钮
      Button('🎨')
        .fontSize(20)
        .width(44)
        .height(44)
        .backgroundColor(theme.colors.surface)
        .fontColor(theme.colors.primary)
        .type(ButtonType.Circle)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.1)',
          offsetY: 4
        })
        .onClick(() => {
          this.isVisible = !this.isVisible;
        })
      
      // 主题选择面板
      if (this.isVisible) {
        Column({ space: 12 }) {
          Text('选择主题')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(theme.colors.textPrimary)
            .margin({ top: 12 })
          
          // 主题网格
          Grid() {
            ForEach(ThemeManager.getThemes(), (theme: ThemeConfig, index: number) => {
              GridItem() {
                this.ThemeOption(theme, index)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .width('100%')
          .margin({ top: 12, bottom: 12 })
        }
        .width(280)
        .backgroundColor(theme.colors.background)
        .borderRadius(16)
        .padding(16)
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.1)',
          offsetY: 4
        })
        .margin({ top: 8 })
        .position({ x: -120 })
      }
    }
    .alignItems(HorizontalAlign.Start)
  }
}