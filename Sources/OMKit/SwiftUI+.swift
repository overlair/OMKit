//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import SwiftUI
import Combine




@available(macOS 10.15, *)
@available(iOS 13.0, *)
extension Binding {
    static func uni(get: @escaping () -> Value) -> Binding<Value> {
        .init {
            get()
        } set: { _ in
            
        }

    }
}



@available(macOS 12, *)
@available(iOS 15.0, *)
extension View {
  @inlinable
  public func reverseMask<Mask: View>(
    alignment: Alignment = .center,
    @ViewBuilder _ mask: () -> Mask
  ) -> some View {
    self.mask {
      Rectangle()
        .overlay(alignment: alignment) {
          mask()
            .blendMode(.destinationOut)
        }
    }
  }
}

//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape( RoundedCorner(radius: radius, corners: corners) )
//    }
//}
//
//@available(macOS 10.15, *)
//struct RoundedCorner: Shape {
//
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
//

/*
    Background
 */
#if os(iOS)
@available(iOS 15.0, *)
public struct BarBackground: ViewModifier {
    var tint: Color = Color(UIColor.systemGray6)
    var hPadding: CGFloat = 8
    var vPadding: CGFloat = 8
    var maxHeight: CGFloat? = nil
    var radius: CGFloat = 16
    var ignoreEdges: Edge.Set? = nil

    public init(tint: Color = Color(UIColor.systemGray6),
         hPadding: CGFloat = 8,
         vPadding: CGFloat = 8,
         maxHeight: CGFloat? = nil,
         radius: CGFloat = 16,
        ignoreEdges: Edge.Set? = nil) {
        self.tint = tint
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.maxHeight = maxHeight
        self.radius = radius
        self.ignoreEdges = ignoreEdges
    }
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.horizontal, hPadding)
            .padding(.vertical, vPadding)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: maxHeight)
            .background {
                Group {
                    if let ignoreEdges {
                        Rectangle()
                            .fill(tint)
                            .ignoresSafeArea(edges: ignoreEdges)
                    } else {
                        Rectangle()
                            .fill(tint)
                            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
                    }
                }

            }
        
    }
}


public extension View {
    func shadow(
        color: Color = OMShadow.primaryColor,
        radius: CGFloat  = 8,
        offset: CGSize = .init(width: 0, height: 4)
    ) -> some View {
        self.shadow(color: color, radius: radius, x: offset.width, y: offset.height)
    }
}


public extension View {
    func button(
        size: CGFloat = OMButton.size,
        hPadding: CGFloat = 10,
        vPadding: CGFloat = 10,
        opacity: CGFloat = 0.08,
        radius: CGFloat = OMButton.radius,
        tint: Color? = nil,
        shadowTint: Color? = nil,
        shadowRadius: CGFloat  = 8,
        shadowOffset: CGSize = .init(width: 0, height: 4)
    
    ) -> some View {
            self.modifier(ButtonBackground(size: size,
                                           hPadding: hPadding,
                                           vPadding: vPadding,
                                           opacity: opacity,
                                           radius: radius,
                                           tint: tint,
                                           shadowTint: shadowTint,
                                           shadowRadius: shadowRadius,
                                           shadowOffset: shadowOffset
                                          ))
    }
}

@available(iOS 15.0, *)
public struct ButtonBackground: ViewModifier {
    var size: CGFloat = 20
    var hPadding: CGFloat = 10
    var vPadding: CGFloat = 10
    var opacity: CGFloat = 0.08
    var radius: CGFloat = 12
    var tint: Color? = .blue
    var shadowTint: Color? = nil
    var shadowRadius: CGFloat  = 8
    var shadowOffset: CGSize = .init(width: 0, height: 4)


    public init(size: CGFloat = 20,
                hPadding: CGFloat = 8,
                vPadding: CGFloat = 8,
                opacity: CGFloat = 0.08,
                radius: CGFloat = 12,
                tint: Color? = .blue,
                shadowTint: Color? = nil,
                shadowRadius: CGFloat  = 8,
                shadowOffset: CGSize = .init(width: 0, height: 4)) {
        self.size = size
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.opacity = opacity
        self.radius = radius
        self.tint = tint
        self.shadowTint = shadowTint
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
    }

    public func body(content: Content) -> some View {
        let font = UIFont.systemFont(ofSize: size)
        
        Group {
            if let tint {
                 content
                    .foregroundStyle(tint)
            } else {
                content
            }
        }
            .font(Font.system(size: size))
            .frame(height: font.lineHeight)
            .frame(minWidth: font.lineHeight, maxHeight: .infinity)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.vertical, vPadding)
            .padding(.horizontal, hPadding)
            .background {
                if let shadow = shadowColor {
                    Rectangle()
                        .fill(tint ?? .clear)
                        .opacity(opacity)
                        .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
                        .shadow(color: shadow, radius: shadowRadius, offset: shadowOffset)
                } else {
                    Rectangle()
                        .fill(tint ?? .clear)
                        .opacity(opacity)
                        .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))

                }
            }
            .tint(tint)
            .frame(minWidth: 40, minHeight: 36)
            .contentShape(Rectangle())
    }
}

@available(iOS 15.0.0, *)
public struct RoundedBackground: ViewModifier {
    var hPadding: CGFloat = 12
    var vPadding: CGFloat = 6
    var radius: CGFloat = 12
    
    public init(hPadding: CGFloat = 12, vPadding: CGFloat = 6, radius: CGFloat = 12) {
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.radius = radius
    }
    public func body(content: Content) -> some View {
        content
            .padding(.horizontal, hPadding)
            .padding(.vertical, vPadding)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: radius,
                                        style: .continuous))

    }
}


/*
    MENU
 */

@available(iOS 15.0, *)
public extension View {
    public  func menu(menu: UIMenu) -> some View {
        self.modifier(MenuModifier(menu: menu))
    }
}

@available(iOS 15.0, *)
public struct MenuModifier: ViewModifier {
    let menu: UIMenu
    @State var lastTrigger: Date? = nil
    @State var isTriggered = false
    @State var id = UUID()

    public init(menu: UIMenu) {
        self.menu = menu
//        self._menu = .constant(menu)
    }
    
//    public init(menu: Binding<UIMenu>) {
//        self._menu = menu
//    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(isTriggered ? 0.9 : 1)
            .opacity(isTriggered ? 0.5 : 1)
            .overlay {
                MenuRepresentable(menu: menu, lastTrigger: $lastTrigger)
                    .id(id)
            }
            .onChange(of: lastTrigger) { _ in
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) { isTriggered = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.14) {
                        withAnimation(.easeInOut) { isTriggered = false }
                    }
                }
            }
    }
}
@available(iOS 15.0, *)
public struct MenuRepresentable: UIViewRepresentable {
     let menu: UIMenu
    @Binding var lastTrigger: Date?
    let view = UIButton()

    public func makeUIView(context: Context) -> some UIView {
        view.backgroundColor = nil
        view.menu = menu
        view.showsMenuAsPrimaryAction = true
    
        view.addTarget(context.coordinator, action: #selector(Coordinator.menuTriggered), for: .menuActionTriggered)
        view.addTarget(context.coordinator, action: #selector(Coordinator.menuExit), for: .touchDragOutside)

        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        print("MENU TRYINGN TO UPDATE")
        if let uiView = uiView as? UIButton, uiView.menu != menu {
            uiView.menu = menu
            print("MENU UPDATING")
        }
        
    }
    
    public func makeCoordinator() -> Coordinator {
        let publisher = view.publisher(for: \.isHeld)
        return Coordinator(lastTrigger: $lastTrigger, isMenuOpen: publisher)
    }
    
    public class Coordinator: NSObject {
        @Binding var lastTrigger: Date?
        let isMenuOpen: NSObject.KeyValueObservingPublisher<UIButton, Bool>
        var cancellables = Set<AnyCancellable>()
        init(lastTrigger: Binding<Date?>, isMenuOpen: NSObject.KeyValueObservingPublisher<UIButton, Bool>) {
            self._lastTrigger = lastTrigger
            self.isMenuOpen = isMenuOpen
            
            isMenuOpen.sink { isShowing in
//                print(isShowing)
            }
            .store(in: &cancellables)
        }
        
        @objc func menuTriggered(sender: UIButton) {
            print("OPEN", sender.isHeld)
            lastTrigger = .now
        } 
        
        @objc func menuExit(sender: UIButton) {
            print("close", sender.isHeld)
        }
        
       
    }
}
#endif



@available(macOS 10.15, *)
@available(iOS 13.0, *)
extension View {
    var body: some View { EmptyView() }
}

@available(macOS 11, *)
@available(iOS 14.0, *)
struct V<Content: View>: View {
    var spacing: CGFloat = 0
    var alignment: HorizontalAlignment = .leading
    var lazy: Bool = false
    var pinned: PinnedScrollableViews = []
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if lazy {
            LazyVStack(alignment: alignment, spacing: spacing, pinnedViews: pinned, content: content)
        } else {
            VStack(alignment: alignment, spacing: spacing, content: content)
        }
    }
}


@available(macOS 11, *)
@available(iOS 14.0, *)
struct H<Content: View>: View {
    var spacing: CGFloat = 0
    var alignment: VerticalAlignment = .center
    var lazy: Bool = false

    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if lazy {
            LazyHStack(alignment: alignment, spacing: spacing, content: content)
        } else {
            HStack(alignment: alignment, spacing: spacing, content: content)
        }
    }
}



@available(macOS 10.15, *)
@available(iOS 14.0, *)
struct Z<Content: View>: View {
    var alignment: Alignment = .center
    @ViewBuilder var content: () -> Content
    
    var body: some View { ZStack(alignment: alignment, content: content) }
}




@available(iOS 13.0.0, *)
public struct Separator: View {
    public var tint: Color = Color.secondary.opacity(0.2)
    public var height = CGFloat(1)
    public var hPadding = CGFloat(24)
    public var vPadding = CGFloat(12)
    
    public init(tint: Color = Color.secondary.opacity(0.4),
         height: CGFloat = CGFloat(1),
         hPadding: CGFloat = CGFloat(24),
         vPadding: CGFloat = CGFloat(12)) {
        self.tint = tint
        self.height = height
        self.hPadding = hPadding
        self.vPadding = vPadding
    }
    public var body: some View {
        
        Rectangle()
            .fill(tint)
            .frame(height: height)
            .padding(.horizontal, hPadding)
            .padding(.vertical, vPadding)

    }
}




public enum OMToastAlignment {
    case top, center, bottom
    
    var value: Alignment {
        switch self {
        case .top: return .top
        case .center: return .center
        case .bottom: return .bottom
        }
    }
    
    var transition: AnyTransition {
        switch self {
        case .top: return .scale.combined(with: .move(edge: .top)).combined(with: .opacity)
        case .center: return .opacity.combined(with: .scale)
        case .bottom: return .scale.combined(with: .move(edge: .bottom)).combined(with: .opacity)
        }
    }
}

public extension View {
    public func toast<Toast: View>(isPresented: Binding<Bool>,
               alignment: OMToastAlignment = .top,
               toast: @escaping () -> Toast) -> some View {
        self.modifier(ToastViewModifier(isPresented: isPresented,
                                        alignment: alignment,
                                        toast: toast))
    }
    
    public func toast<Toast: View, T: Equatable>(item: Binding<T?>,
               alignment: OMToastAlignment = .top,
               toast: @escaping (T) -> Toast) -> some View {
        self.modifier(ToastOptionalViewModifier(item: item,
                                                alignment: alignment,
                                                toast: toast))
    }
}
public struct ToastViewModifier<Toast: View>: ViewModifier {
    @Binding var isPresented: Bool
    var alignment: OMToastAlignment = .top
    @ViewBuilder var toast: Toast

    public init(isPresented: Binding<Bool>,
         alignment: OMToastAlignment = .top,
         toast: @escaping () -> Toast) {
        self._isPresented = isPresented
        self.toast = toast()
        self.alignment = alignment
    }
    
    public func body(content: Content) -> some View {
        let topPadding: CGFloat = alignment.value == .top ? 24 : 0
        let bottomPadding: CGFloat = alignment.value == .bottom ? 24 : 0
        
        content
        .overlay {
            if isPresented {
                Color.clear
                    .overlay(alignment: alignment.value,
                             content: { toast })
                    .padding(.top, topPadding)
                    .padding(.bottom, bottomPadding)
                    .transition(alignment.transition)
            }
        }
        .animation(.bouncy, value: isPresented)
    }
}

public struct ToastOptionalViewModifier<Toast: View, T: Equatable>: ViewModifier {
    @Binding var item: T?
    var alignment: OMToastAlignment = .top
    @ViewBuilder var toast: (T) -> Toast

    public init(item: Binding<T?>,
         alignment: OMToastAlignment = .top,
         toast: @escaping (T) -> Toast) {
        self._item = item
        self.toast = toast
        self.alignment = alignment
    }
    
    public func body(content: Content) -> some View {
        let topPadding: CGFloat = alignment.value == .top ? 24 : 0
        let bottomPadding: CGFloat = alignment.value == .bottom ? 24 : 0
        
        content
        .overlay {
            if let item {
                Color.clear
                    .overlay(alignment: alignment.value,
                             content: { toast(item) })
                    .padding(.top, topPadding)
                    .padding(.bottom, bottomPadding)
                    .transition(alignment.transition)
            }
        }
        .animation(.bouncy, value: item)
    }
}


public struct OMProgressToast: View {
    public var body: some View {
        #if os(iOS)
        ProgressView()
            .scaleEffect(2)
            .padding(48)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(UIColor.systemGray4).opacity(0.5), radius: 4, y: 2)
        #endif
        #if os(macOS)
        ProgressView()
            .scaleEffect(2)
            .padding(48)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        #endif

    }
}





#if os(iOS)

public struct OMTextField: View {
    public let text: CurrentValueSubject<String, Never>
    public var placeholder: String = ""
    public var size: CGFloat = 16
    let height: CGFloat
    @State var internalText: String
    
    public init(text: CurrentValueSubject<String, Never>,
                placeholder: String = "",
                size: CGFloat = 16) {
        self.text = text
        self.placeholder = placeholder
        self.size = size
        self._internalText = State(initialValue: text.value)
        self.height = UIFont.systemFont(ofSize: size).lineHeight
    }
    public var body: some View {
        TextField(placeholder, text: $internalText)
            .font(Font.system(size: size))
            .frame(height: height)
            .onChange(of: internalText, perform: onTextChange)
        
//        GeometryReader { geo in
//            TextFieldRepresentable(text: text, width: geo.size.width, size: size, placeholder: placeholder)
////                .frame(width: geo.size.width)
//        }
//            .frame(height: UIFont.systemFont(ofSize: size).lineHeight)
    }
    
    func onTextChange(_ newText: String) {
        text.value = newText
    }
}


import Combine
struct TextFieldRepresentable: UIViewRepresentable {
    let text: CurrentValueSubject<String, Never>
    var setter: PassthroughSubject<String, Never>? = nil
    var width: CGFloat = 100
    var size: CGFloat = 16
    var placeholder: String = ""

    func makeUIView(context: Context) -> some UIView {
        let v = UITextField()
        v.font = UIFont.systemFont(ofSize: size)
        v.addTarget(context.coordinator, action: #selector(Coordinator.editingChanged), for: .editingChanged)
        v.text = text.value
        v.placeholder = placeholder
        v.delegate = context.coordinator
        v.widthAnchor.constraint(equalToConstant: width)
        return v
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: text, setter: setter)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let text: CurrentValueSubject<String, Never>
        var setter: PassthroughSubject<String, Never>?
        var cancellables = Set<AnyCancellable>()
        
        init(text: CurrentValueSubject<String, Never>, setter: PassthroughSubject<String, Never>?) {
            self.text = text
            self.setter = setter
            
            setter?
                .sink(receiveValue: { _ in })
                .store(in: &cancellables)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        @objc func editingChanged(sender: UITextField) {
            guard let fieldText = sender.text else { return }
            text.value = fieldText
        }
    }
}

#endif


extension ColorScheme {
    public var isDark: Bool { self == .dark }
}
