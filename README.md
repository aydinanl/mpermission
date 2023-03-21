# MPermission
## Permission Manager with SwiftUI 
Standalone package for managing permission on iOS platform builded with SwiftUI.

#### Currently Supported Permission Types
`Location`, `Camera`, `Calendar`, `Notification`

## Installation
### Requirements
* iOS 15 or later.
* macOS 10.15 or later.
* xCode 14, Swift 5.7

#### SPM
Open File → Swift Packages → Add Package Dependency then search with package URL, find and add package to project.
```sh
https://bitbucket.org/aydinanl/mpermission
```

## Usage
Firstly, create a shared singleton object as holding necessary builder data from your aplication as example file:
```sh
https://bitbucket.org/aydinanl/workspace/snippets/Mz8GKr
```
Import MPermission to view you want to use.
```sh
import MPermission
```

Create a observed object from `MPermissionManager` with wanted permission setter `MPTypeSetter` like in example `MPermissionsConfig`.

```sh
    @ObservedObject var permissionManager = MPermissionManager(
        permissions: [
            MPermissionsConfig.shared.getSetter(for: .location, required: true),
            MPermissionsConfig.shared.getSetter(for: .calendar),
            MPermissionsConfig.shared.getSetter(for: .camera)
        ]
    )
```

Then in SwiftUI's body, check for permission requirements before presenting your custom view.

```sh
    if permissionManager.hasAnyPermissionRequest ?? false {
        permissionManager.present(with: MPermissionsConfig.shared.permissionUI)
    } else {
        ContentView()
    }
```

`hasAnyPermissionRequest` is an observed object, so that permission changes effect directly to continue your views.

For presenting request permission with your own configurations, review example `MPermissionsConfig` of `permissionUI` property.
