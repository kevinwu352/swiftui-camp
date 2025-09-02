//
//  PopoverBootcamp.swift
//  bootcamp
//
//  Created by Kevin Wu on 9/2/25.
//

import SwiftUI
import PopupView

struct PopoverBootcamp: View {
    @State var showBanner = false
    @State var showSheet = false
    @State var showBubble = false

    @State var showAlert = false

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Color.red
                .frame(width: 200, height: 100)
                .clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20)))

            Button {
//                showBanner.toggle()
//                showSheet.toggle()
//                showBubble.toggle()

                showAlert.toggle()

//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    self.showSheet.toggle()
//                }
            } label: {
                Image(systemName: "play").padding()
            }

            Button {
                print("clicked")
            } label: { Text("click") }
        }
        .bannerView(isPresented: $showBanner)
        .sheetView(isPresented: $showSheet)
        .bubbleView(isPresented: $showBubble)
        .alertView(isPresented: $showAlert)
    }
}

#Preview {
    PopoverBootcamp()
}


// banner, round corner: none
struct BannerView: View {
    var body: some View {
        VStack {
            Text("banner")
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(Color.yellow)
    }
}
extension View {
    func bannerView(isPresented: Binding<Bool>) -> some View {
        popup(isPresented: isPresented) {
            BannerView()
        } customize: {
            $0.type(.floater(verticalPadding: 0, useSafeAreaInset: true))
                .position(.top)
            //.appearFrom()
            //.disappearTo()
            //.animation()
                .autohideIn(3)
            //.dismissibleIn()
            //.dragToDismiss(true)
            //.closeOnTap(true)
            //.closeOnTapOutside(false)
            //.allowTapThroughBG(true)
            //.backgroundColor(Color.black.opacity(0.4))
            //.backgroundView()
            //.useKeyboardSafeArea(false)
            //.willDismissCallback { }
            //.dismissCallback { }
        }
    }
}

// sheet, round corner: half
struct SheetView: View {
    var body: some View {
        VStack {
            Text("sheet")
        }
        .padding(EdgeInsets(top: kStatusBarH + 20, leading: 0, bottom: 20, trailing: 0))
        .frame(maxWidth: .infinity)
        .background(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20)).fill(Color.yellow))
        //.background(Color.yellow.clipShape(UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20, bottomTrailing: 20))))
    }
}
extension View {
    func sheetView(isPresented: Binding<Bool>) -> some View {
        popup(isPresented: isPresented) {
            SheetView()
        } customize: {
            $0.type(.floater(verticalPadding: 0, useSafeAreaInset: false)) // 注意这里没用安全区，因为加在上面 padding 里了
                .position(.top)
            //.appearFrom()
            //.disappearTo()
            //.animation()
            //.autohideIn(3)
            //.dismissibleIn()
            //.dragToDismiss(true)
                .closeOnTap(false)
            //.closeOnTapOutside(false)
            //.allowTapThroughBG(true)
            //.backgroundColor(Color.black.opacity(0.4))
            //.backgroundView()
            //.useKeyboardSafeArea(false)
            //.willDismissCallback { }
            //.dismissCallback { }
        }
    }
}

// bubble, round corner: all
struct BubbleView: View {
    var body: some View {
        VStack {
            Text("bubble")
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow))
        //.background(Color.yellow.clipShape(RoundedRectangle(cornerRadius: 10)))
        .padding(.horizontal, 10)
    }
}
extension View {
    func bubbleView(isPresented: Binding<Bool>) -> some View {
        popup(isPresented: isPresented) {
            BubbleView()
        } customize: {
            $0.type(.floater(verticalPadding: 10, useSafeAreaInset: true))
                .position(.top)
            //.appearFrom()
            //.disappearTo()
            //.animation()
            //.autohideIn(3)
            //.dismissibleIn()
            //.dragToDismiss(true)
                .closeOnTap(false)
            //.closeOnTapOutside(false)
            //.allowTapThroughBG(true)
            //.backgroundColor(Color.black.opacity(0.4))
            //.backgroundView()
            //.useKeyboardSafeArea(false)
            //.willDismissCallback { }
            //.dismissCallback { }
        }
    }
}


// Alert
struct AlertView: View {
    var body: some View {
        VStack {
            Text("alert")
            Text("I appreciate you choosing to spend some of your day with me.")
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .padding(.horizontal, 20)
    }
}
extension View {
    func alertView(isPresented: Binding<Bool>) -> some View {
        popup(isPresented: isPresented) {
            AlertView()
        } customize: {
            $0.type(.default)
                .position(.center)
                .appearFrom(.centerScale)
            //.disappearTo()
                .animation(.spring(duration: 0.15, bounce: 0.4))
            //.autohideIn(3)
            //.dismissibleIn()
                .dragToDismiss(false)
                .closeOnTap(false)
            //.closeOnTapOutside(false)
                .allowTapThroughBG(false)
                .backgroundColor(Color.black.opacity(0.4))
            //.backgroundView()
            //.useKeyboardSafeArea(false)
            //.willDismissCallback { }
            //.dismissCallback { }
        }
    }
}


// ================================================================================

// PopupType 类型

// default 通常是居于屏幕中间的

// toast - fitted to screen i.e. without padding and ignoring safe area
// 会忽略安全区，内容会被安全区遮挡，不用这个

// floater(verticalPadding: CGFloat = 10, horizontalPadding: CGFloat = 10, useSafeAreaInset: Bool = true)
//    verticalPadding 如果刚好等于安全区高度，内部颜色会伸进去，多一个像素就不会了
//    horizontalPadding 在手机上貌似没啥用
//    useSafeAreaInset 为真，算垂直边距的时候会加上安全区高度，所以会空出安全区，内容在安全区外面
//
// 如果弹窗内容这样写，但它从安全区弹出来的时候，颜色有点粘连，先是很高，脱离安全区以后颜色变矮
//    ZStack {
//        Text("123")
//    }
//    .frame(maxWidth: .infinity)
//    .background(Color.brown)
// 解决方法
//    ZStack {
//        RoundedRectangle(cornerRadius: 30)
//            .fill(Color.purple)
//            .frame(height: 100) // 但是这里要固定高度，或者在 ZStack 上固定高度，这办法也一般
//        Text("123")
//    }
//    .frame(maxWidth: .infinity)
//    .padding(.horizontal, 10)
// 最佳方案
//    VStack {
//        Text("123")
//    }
//    .padding(.vertical, 20)
//    .frame(maxWidth: .infinity)
//    .background(RoundedRectangle(cornerRadius: 10).fill(Color.yellow))
//    .padding(.horizontal, 10)

// scroll(headerView: AnyView)
// 用到再来研究吧
// adds a scroll to your content, if you scroll to top of this scroll - the gesture will continue into popup's drag dismiss.


// ================================================================================

//    var type: PopupType = .default
//
//    > 不清楚具体作用
//    var displayMode: DisplayMode = .window
//
//    var position: Position?


//    var appearFrom: AppearAnimation?
//
//    > 如果为空，拷贝 appearFrom，但是做反向动画
//    var disappearTo: AppearAnimation?
//
//    > 默认是 .easeOut(duration: 0.3)，可以改成弹簧动画
//    var animation: Animation = .easeOut(duration: 0.3)


//    /// If nil - never hides on its own
//    var autohideIn: Double?
//
//    在此时间内 closeOnTap / closeOnTapOutside / drag 失效
//    /// Only allow dismiss by any means after this time passes
//    var dismissibleIn: Double?
//
//    设置 dismissibleIn 的时候，如果不给 dismissEnabled 传值，那上面那三个失效不了，因为 dismissEnabled 的默认值是 .constant(true)
//    /// Becomes true when `dismissibleIn` times finishes. Makes no sense if `dismissibleIn` is nil
//    var dismissEnabled: Binding<Bool> = .constant(true)


//    /// Should allow dismiss by dragging - default is `true`
//    var dragToDismiss: Bool = true
//
//    /// Minimum distance to drag to dismiss
//    var dragToDismissDistance: CGFloat?
//
//    /// Should close on tap - default is `true`
//    var closeOnTap: Bool = true
//
//    当 allowTapThroughBG 为 true 时，这里不起作用，这是有意为之吗？
//    /// Should close on tap outside - default is `false`
//    var closeOnTapOutside: Bool = false
//
//    /// Should allow taps to pass "through" the popup's background down to views "below" it.
//    /// .sheet popup is always allowTapThroughBG = false
//    var allowTapThroughBG: Bool = true


//    /// Background color for outside area
//    var backgroundColor: Color = .clear
//
//    /// Custom background view for outside area
//    var backgroundView: AnyView?


//    底部弹窗包含输入框时用
//    /// move up for keyboardHeight when it is displayed
//    var useKeyboardSafeArea: Bool = false


//    /// called when when dismiss animation starts
//    var willDismissCallback: (DismissSource) -> () = {_ in}
//
//    /// called when when dismiss animation ends
//    var dismissCallback: (DismissSource) -> () = {_ in}


// 底部弹窗里面能拖动那个条的做法
//    Color.black
//        .opacity(0.2)
//        .frame(width: 30, height: 6)
//        .clipShape(Capsule())
//        .padding(.top, 15)
//        .padding(.bottom, 10)


// 注意下面这个坑
struct PopoverContent1View : View {
    @State var showPopup = false
    @State var a = false

    var body: some View {
        Button("Button") {
            showPopup.toggle()
        }
        .popup(isPresented: $showPopup) {
            VStack {
                Button("Switch a") {
                    a.toggle()
                }
                a ? Text("on").foregroundStyle(.green) : Text("off").foregroundStyle(.red)
            }
        } customize: {
            $0
                .type(.floater())
                .closeOnTap(false)
                .position(.top)
        }
    }
}

struct PopoverContent2View : View {
    @State var showPopup = false
    @State var a = false

    var body: some View {
        Button("Button") {
            showPopup.toggle()
        }
        .popup(isPresented: $showPopup) {
            PopupContent(a: $a)
        } customize: {
            $0
                .type(.floater())
                .closeOnTap(false)
                .position(.top)
        }
    }
}
struct PopupContent: View {
    @Binding var a: Bool

    var body: some View {
        VStack {
            Button("Switch a") {
                a.toggle()
            }
            a ? Text("on").foregroundStyle(.green) : Text("off").foregroundStyle(.red)
        }
    }
}
