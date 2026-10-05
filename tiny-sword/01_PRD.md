# Game Vision

1. 一句话描述游戏：一个玩家经营自己的王国制造兵种最终征服所有玩家/AI阵营
2. 玩家主要在做什么：
   1. 发育
   2. 爆兵
   3. 掠夺其他阵营资源
   4. 攻击中立资源

3. 游戏类型：PVP，RTS
4. 特点：轻量化
5. 游戏结构：一局30-40分钟左右然后重新开始
6. 控制：
   1. 鼠标点击
   2. 框选多个单位
7. 控制来源：
   1. 玩家
   2. AI: 没有其他人类玩家时可选择的对手

8. 单人和多人
9. 美术视角: 2D Top-down的卡通风格
10. 项目规模：2 - 3个月
11. 团队: 一人开发
    1. 美术来源于免费素材库Tiny Sword
    2. 目前无音效和音乐
    3. 程序、设计由本人配合AI完成
12. 目标：学习 + Portfolio
13. 如果整个游戏最后只能保留一个机制，你最希望玩家记住哪个机制？
    - 轻量化建造发育重进攻策略

# Game Pillars

## Lightweight Economy

经济系统足够简单

- 人口 - 影响一个阵营能否继续制造单位
- 金币 - 产出新单位所需花费
  - 金矿：大量金币来源
  - 畜牧（羊）：少量 ~ 中等金币来源
- 木头 - 建造新建筑所需材料

## Aggression First

```text
基地附近：
少量安全资源

地图中央：
高价值矿点
中立营地
资源箱

敌方领地：
可以掠夺
```

## Simple Army Control

```text
左键：选择 / 框选
右键：Move / Attack / Gather 等命令
```

## Short Strategic Decisions

基础兵种

```text
Warrior
Lancer
Monk
Pawn
Archer
```

# Project Goals

制作一款完整可玩的轻量化 2D Top-down RTS。
- 单局时长控制在约 30–40 分钟。
- 核心体验围绕：
  - 快速发育
  - 快速爆兵
  - 主动争夺地图资源
  - 高频率进攻
- 保持较低的学习和操作门槛，避免传统 RTS 过度复杂的经济管理。
- 完成一个适合展示在 Portfolio 中的完整游戏项目。
- 通过项目学习和实践：
  - RTS 单位选择与控制
  - AI Controller
  - 路径移动
  - 经济与生产系统
  - 阵营系统
  - 基础多人游戏架构（如果时间允许）

# Constraints

## Development

- Solo development
- Development time: 2–3 months
- Engine: Godot
- Programmer / Designer: Developer + AI assistance

## Art

- 2D Top-down cartoon style
- Primary art source: Tiny Sword free asset pack
- 尽量避免需要大量自制美术资源的功能

## Audio

- 当前没有原创音乐或音效
- 优先使用免费或可商用素材

## Scope

- 项目必须适合单人开发
- 优先完成核心 RTS loop，而不是大量内容
- 新系统只有在支持核心体验时才加入

# MVP Scope

MVP should provide one complete playable RTS match from start to finish.

## 对局

- 1个玩家阵营
- 1个AI阵营
- 1张可游玩地图
- 游戏可以开始，结束，和重新开始
- 清晰的输赢情况

## Economy

- Gold
- Wood
- Population
- Resource gathering
- Resource spending

## Units

- Worker / Pawn
- Basic melee unit
- Basic ranged unit
- At least one additional combat unit

## Buildings

- 主城堡
- 人口建筑
- 单位生产建筑

## Controls

- Single unit selection
- Box selection
- Multiple-unit selection
- Move command
- Attack command
- Resource interaction

## Combat

- Unit health
- Damage
- Attack range
- Attack speed
- Death
- Basic target acquisition

## AI

AI must be able to:

- Develop economy
- Produce units
- Build an army
- Attack the player

## UI

- Resource display
- Selected unit information
- Production controls
- Win / Loss screen

# Non-Goals

The following features are explicitly outside the MVP scope.

- Campaign mode
- Story system
- Large technology tree
- Equipment / inventory system
- Ranked matchmaking
- Replay system
- Spectator mode
- Mod support
- Complex diplomacy
- Advanced formation system
- Large-scale unit customization

## Deferred Features

- Procedurally generated maps
- New enemy/neutral units
  - New resources
  - Recruit

# Success Criteria

The project is considered successful when:

## Playability

- A player can start a match and play until a clear win or loss state.
- A full Player vs AI match can be completed without developer intervention.
- A typical match lasts approximately 30–40 minutes.

## Core Loop

The following loop works end-to-end:

Develop Economy
→ Produce Army
→ Contest Resources
→ Attack Enemy
→ Expand
→ Destroy Enemy

## Controls

- Player can reliably select and box-select units.
- Player can issue move and attack commands to groups of units.
- Controlling an army does not require excessive micromanagement.

## AI

- AI can independently develop, produce an army, and attack the player.

## Stability

- No major crash or game-breaking bug during a complete match.

## Portfolio

- The game has a presentable main menu / gameplay / end screen.
- Core systems can be demonstrated clearly in a gameplay video.
- Source code is organized enough to explain the project's architecture.