// entry/src/main/ets/pages/Index.ets
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  // 用于控制相机预览画面的控制器
  private mXComponentController: XComponentController = new XComponentController();

  // 模拟状态：当前是拍照还是录像
  @State isRecording: boolean = false;

  // 页面加载时检查权限（这里只是简单示意，实际开发建议封装工具类）
  aboutToAppear() {
    this.requestPermissions();
  }

  requestPermissions() {
    let context = getContext(this) as common.UIAbilityContext;
    let atManager = abilityAccessCtrl.createAtManager();
    // 申请相机和麦克风权限
    atManager.requestPermissionsFromUser(context, ['ohos.permission.CAMERA', 'ohos.permission.MICROPHONE'])
      .then((data) => {
        console.info('权限申请结果:', JSON.stringify(data));
      });
  }

  build() {
    // 使用 Stack 布局，让 UI 控件“浮”在相机预览画面之上
    Stack({ alignContent: Alignment.Bottom }) {

      // Layer 1: 底层 - 相机取景器 (Viewfinder)
      // 这是未来显示摄像头画面的地方
      XComponent({
        id: 'cameraSurface',
        type: 'surface',
        controller: this.mXComponentController
      })
        .onLoad(() => {
          // 这里获取 surfaceId，将来传给 CameraKit
          let surfaceId = this.mXComponentController.getXComponentSurfaceId();
          console.info('获取到 Surface ID:', surfaceId);
          // TODO: 在这里调用初始化相机的函数
        })
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Black) // 相机未启动时显示黑色

      // Layer 2: 顶层 - 辅助线 (可选，增加专业感)
      this.GridLines()

      // Layer 3: 顶层 - UI 控件区域
      Column() {
        // --- 顶部工具栏 (闪光灯、设置等) ---
        Row() {
          // Image($r('app.media.app_icon')) // 替换为你自己的图标，或使用Text代替
          //   .width(24).height(24).fillColor(Color.White)
          // Text("HD")
          //   .fontColor(Color.White).fontWeight(FontWeight.Bold)
          // Image($r('app.media.app_icon')) // 替换图标
          //   .width(24).height(24).fillColor(Color.White)
        }
        .width('100%')
        .padding({ top: 40, left: 20, right: 20 })
        .justifyContent(FlexAlign.SpaceBetween)

        // 中间留白，让出取景区域
        Blank()

        // --- 底部操作区 ---
        Column() {
          // 模式切换文字 (拍照 / 录像)
          Row({ space: 20 }) {
            Text("录像")
              .fontColor(this.isRecording ? Color.Yellow : Color.White)
              .fontSize(16)
              .onClick(() => this.isRecording = true)
            Text("拍照")
              .fontColor(!this.isRecording ? Color.Yellow : Color.White)
              .fontSize(16)
              .onClick(() => this.isRecording = false)
          }
          .margin({ bottom: 20 })

          // 底部控制栏 (相册、快门、翻转)
          Row() {
            // 左侧：相册预览圆点
            Button() {
              // 这里通常放最后一张照片的缩略图
            }
            .width(50)
            .height(50)
            .backgroundColor(Color.Gray)
            .type(ButtonType.Circle)

            // 中间：快门按钮 (核心需求)
            Stack({ alignContent: Alignment.Center }) {
              // 外圈
              Circle({ width: 80, height: 80 })
                .fill(Color.Transparent)
                .stroke(Color.White)
                .strokeWidth(4)
              // 内芯 (按下会有动画效果)
              Circle({ width: 60, height: 60 })
                .fill(this.isRecording ? Color.Red : Color.White)
            }
            .onClick(() => {
              // TODO: 触发拍照或录像逻辑
              console.info("点击了快门！");
            })

            // 右侧：翻转摄像头图标
            Button({ type: ButtonType.Circle }) {
              Text("翻转").fontColor(Color.White).fontSize(12)
            }
            .width(50)
            .height(50)
            .backgroundColor('#33FFFFFF') // 半透明背景
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(180) // 底部操作区高度
        .backgroundColor('#66000000') // 半透明黑色背景，类似专业相机遮罩
        .padding({ bottom: 30 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween) // 顶底分布
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
  }

  // 构建九宫格辅助线的方法
  @Builder GridLines() {
    Column() {
      Divider().color('#33FFFFFF').strokeWidth(1).width('100%')
      Divider().color('#33FFFFFF').strokeWidth(1).width('100%')
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .hitTestBehavior(HitTestMode.None) // 让点击事件穿透辅助线

    Row() {
      Divider().vertical(true).color('#33FFFFFF').strokeWidth(1).height('100%')
      Divider().vertical(true).color('#33FFFFFF').strokeWidth(1).height('100%')
    }
    .height('100%')
    .width('100%')
    .position({ x: 0, y: 0 })
    .justifyContent(FlexAlign.SpaceEvenly)
    .hitTestBehavior(HitTestMode.None)
  }
}