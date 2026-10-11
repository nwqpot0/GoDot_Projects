MVP

```
Create/Edit Diagram
        ↓
Update UMLProject
        ↓
Save as JSON
        ↓
Close program
        ↓
Load JSON
        ↓
Rebuild same UML diagram
```

我会把 MVP scope 限制为这几个功能：

- 创建 Class node
- 删除 Class node
- 移动 node
- 修改 class name
- 添加/删除 property
- 添加/删除 method
- 创建 relationship
- 删除 relationship
- Save JSON
- Load JSON 并恢复整个图

# UMLProject

```
UMLProject
├── classes[]
└── relationships[]
```

# Class

**MVP**

```
UMLProject
├── classes[]
│   ├── id
│   ├── name
│   ├── position
│   ├── properties[]
│   │   ├── name
│   │   └── type
│   └── methods[]
│       ├── name
│       └── return_type
│
└── relationships[]
    ├── from_id
    ├── to_id
    └── type
```



```
Class
├── Name
├── Stereotype
├── Attributes
│   ├── visibility
│   ├── name
│   ├── type
│   ├── multiplicity
│   ├── default value
│   └── static
├── Operations
│   ├── visibility
│   ├── name
│   ├── parameters
│   ├── return type
│   ├── abstract
│   └── static
└── Relationships
```

节点类型

```
GraphNode - 不需要写连接API，直接用
GraphElement - 自定义连接API
```



# Relationships

**MVP**

Dependency：A 临时使用 B

Association：A 长期持有/知道 B

Inheritance / Generalization：A 是 B 的子类

**以后再加**

- **Realization**

- **Aggregation**
- **Composition**

# GUI

```
┌─────────────────────────────────────────────────────────────┐
│ File  Edit  View  Project                     [Save] [Run] │
├───────────────┬───────────────────────────┬─────────────────┤
│ Project       │                           │ Inspector       │
│               │                           │                 │
│ Classes       │       UML Canvas          │ Name            │
│ - Player      │                           │ Type            │
│ - Weapon      │     [ Player ]            │ Properties      │
│ - Enemy       │        │                  │ Methods         │
│               │        ▼                  │ Relationships   │
│ Relationships │     [ Weapon ]            │                 │
│ - Player→...  │                           │                 │
│               │                           │                 │
├───────────────┴───────────────────────────┴─────────────────┤
│ Status: project saved                     Zoom: 100%        │
└─────────────────────────────────────────────────────────────┘
```

```
GUI (VBoxContainer)
├── ToolbarMargin (MarginContainer)
│   └── Toolbar (HBoxContainer)
│
├── MainMargin (MarginContainer)
│   └── MainSplit (HSplitContainer)
│       ├── ProjectPanel (Panel)
│       └── RightSplit (HSplitContainer)
│           ├── GraphEdit
│           └── InspectorPanel
│
└── StatusMargin (MarginContainer)
    └── StatusBar (HBoxContainer)
```



## Toolbar

```
File
├── New Project
├── Open Project...
├── Save
├── Save As...
├── ─────────────
├── Recent Projects
├── ─────────────
└── Exit
```

```
View
├── Zoom In
├── Zoom Out
├── Reset Zoom
├── ─────────────
├── Show Project Panel
├── Show Inspector
├── Show Grid
└── Snap to Grid
```

```
Project
├── Add Class
├── Add Relationship
├── ─────────────
├── Project Settings...
├── Validate Project
├── ─────────────
└── Generate...
```



## Project Panel

```
Project
├── Classes
│   ├── Player
│   ├── Weapon
│   └── Enemy
└── Relationships
    ├── Player → Weapon
    └── Enemy → Player
```

## GraphEdit Canvas

```
┌──────────────────────┐
│ Player               │
├──────────────────────┤
│ health : float       │
│ speed : float        │
├──────────────────────┤
│ move() : void        │
│ attack() : void      │
└──────────────────────┘
          │
          │ association
          ▼
┌──────────────────────┐
│ Weapon               │
└──────────────────────┘
```

## Inspector

```
InspectorUMLClassElement (VBoxContainer)
│
├── ClassSection
│   ├── SectionTitle        "Class"
│   ├── NameRow
│   │   ├── Label           "Name"
│   │   └── NameEdit
│   └── HSeparator
│
├── PropertiesSection
│   ├── Header
│   │   ├── Label           "Properties"
│   │   ├── Spacer
│   │   └── AddButton       "+"
│   │
│   └── PropertiesList
│
├── HSeparator
│
└── MethodsSection
    ├── Header
    │   ├── Label           "Methods"
    │   ├── Spacer
    │   └── AddButton       "+"
    │
    └── MethodsList
```

```
InspectorPropertyElement (HBoxContainer)
├── NameEdit
├── TypeEdit
└── DeleteButton
```



## Status Bar

Status: Last operation

Issues button: Expand to get current unresolved issues info

Classes count

Relationships count

Zoom

# Project Manager and Validator

- Validator: 
  - 目前全量更新，后续更新增量更新
    - 全量更新可以是static的validating functions
    - 增量更新需要保存状态则需要一个validator instance
  - Project Issue所携带的meta data可以提供关于这个问题的详细信息

```
UMLProject
“现在是什么状态？”

ProjectEditManager
“怎么请求改变状态？”

ProjectValidator
“当前状态有什么问题？”

UI
“怎么显示状态和问题？”
```

# Developer's Tools

## Developer's Mode

```
observe
inject data
trigger actions
inspect state
```

```
DeveloperTools
      ↓
调用真正的 production API

ProblemsPanel.add_problem()
Inspector.show_class()
Canvas.select_node()
```

```
Developer Tools

[Problems]
+ Add Info Problem
+ Add Warning Problem
+ Add Error Problem
+ Add 20 Random Problems
+ Clear Problems

[Canvas]
+ Spawn UML Class
+ Spawn Interface
+ Spawn 20 Classes
+ Select Random Node
+ Delete Selected Node

[Inspector]
+ Show Test Class
+ Refresh Inspector
+ Clear Inspector

[Signals]
☑ Log Signals
☑ Log Selection
☑ Log Model Changes

[State]
Selected Node:
Player

Problems:
8

Canvas Nodes:
14
```

# Testings

```
Unit Test
    ↓
测试纯逻辑

Component Test
    ↓
测试单个 UI / Scene

Developer Mode
    ↓
测试多个组件之间的 interaction
```

