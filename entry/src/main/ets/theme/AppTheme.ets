/*
 * 应用主题配置 - 春夏秋冬四个主题
 */

// 主题配置类
export class ThemeConfig {
  name: string;
  colors: ThemeColors;

  constructor(name: string, colors: ThemeColors) {
    this.name = name;
    this.colors = colors;
  }
}

// 主题颜色接口
export interface ThemeColors {
  primary: string;
  secondary: string;
  accent: string;
  background: string;
  surface: string;
  textPrimary: string;
  textSecondary: string;
  textAccent: string;
  cardBackground: string;
  cardBorder: string;
  buttonPrimary: string;
  buttonSecondary: string;
  buttonText: string;
}

// 春季主题配色 - 巴黎之春
export const SpringTheme = new ThemeConfig('spring', {
  primary: '#D48392',      // 淡粉红 - 主色调
  secondary: '#B73736',    // 深红 - 强调色
  accent: '#CFAA7D',       // 米色 - 辅助色
  background: '#FBFFFF',   // 纯白 - 背景色
  surface: '#EBC9C0',      // 浅粉 - 表面色
  
  textPrimary: '#333333',  // 主文字
  textSecondary: '#666666',// 次文字
  textAccent: '#B73736',   // 强调文字
  
  cardBackground: '#FBFFFF',
  cardBorder: '#EBC9C0',
  
  buttonPrimary: '#D48392',
  buttonSecondary: '#B73736',
  buttonText: '#FFFFFF'
});

// 夏季主题配色 - 海洋夏日
export const SummerTheme = new ThemeConfig('summer', {
  primary: '#4A90E2',      // 天蓝色 - 主色调
  secondary: '#50E3C2',    // 薄荷绿 - 强调色
  accent: '#F5A623',       // 橙色 - 辅助色
  background: '#F8FDFF',   // 淡蓝白 - 背景色
  surface: '#B8E6E6',      // 浅青 - 表面色
  
  textPrimary: '#333333',
  textSecondary: '#666666',
  textAccent: '#4A90E2',
  
  cardBackground: '#FFFFFF',
  cardBorder: '#E6F7FF',
  
  buttonPrimary: '#4A90E2',
  buttonSecondary: '#50E3C2',
  buttonText: '#FFFFFF'
});

// 秋季主题配色 - 金色秋天
export const AutumnTheme = new ThemeConfig('autumn', {
  primary: '#D2691E',      // 巧克力色 - 主色调
  secondary: '#FF7F50',    // 珊瑚橙 - 强调色
  accent: '#8B4513',       // 马鞍棕 - 辅助色
  background: '#FFF8DC',   // 玉米丝 - 背景色
  surface: '#F5DEB3',      // 小麦色 - 表面色
  
  textPrimary: '#333333',
  textSecondary: '#666666',
  textAccent: '#D2691E',
  
  cardBackground: '#FFFFFF',
  cardBorder: '#F5DEB3',
  
  buttonPrimary: '#D2691E',
  buttonSecondary: '#FF7F50',
  buttonText: '#FFFFFF'
});

// 冬季主题配色 - 冰雪冬日
export const WinterTheme = new ThemeConfig('winter', {
  primary: '#708090',      // 石板灰 - 主色调
  secondary: '#87CEEB',    // 天蓝 - 强调色
  accent: '#F0F8FF',       // 爱丽丝蓝 - 辅助色
  background: '#F5F5F5',   // 淡灰 - 背景色
  surface: '#E6E6FA',      // 淡紫 - 表面色
  
  textPrimary: '#333333',
  textSecondary: '#666666',
  textAccent: '#708090',
  
  cardBackground: '#FFFFFF',
  cardBorder: '#E6E6FA',
  
  buttonPrimary: '#708090',
  buttonSecondary: '#87CEEB',
  buttonText: '#FFFFFF'
});

// 当前主题
let currentTheme: ThemeConfig = SpringTheme;

// 主题管理类
export class ThemeManager {
  
  // 获取当前主题
  static getCurrentTheme(): ThemeConfig {
    return currentTheme;
  }
  
  // 切换主题
  static setTheme(themeName: string): void {
    switch (themeName) {
      case 'spring':
        currentTheme = SpringTheme;
        break;
      case 'summer':
        currentTheme = SummerTheme;
        break;
      case 'autumn':
        currentTheme = AutumnTheme;
        break;
      case 'winter':
        currentTheme = WinterTheme;
        break;
      default:
        currentTheme = SpringTheme;
    }
  }
  
  // 获取所有主题列表
  static getThemes(): ThemeConfig[] {
    return [SpringTheme, SummerTheme, AutumnTheme, WinterTheme];
  }
}

// 主题相关的工具函数
export class ThemeUtils {
  
  // 获取阴影效果
  static getShadow(intensity: number = 1): ShadowOptions {
    const baseShadow: ShadowOptions = {
      radius: 8 * intensity,
      color: 'rgba(0,0,0,0.1)',
      offsetY: 4 * intensity
    };
    return baseShadow;
  }
}