import Foundation

public enum DragState {
    case inactive
    case dragging(translation: CGSize)
}
