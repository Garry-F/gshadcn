SHADCN = SHADCN or {}
SHADCN.Config = SHADCN.Config or {}

SHADCN.Rounds = {
    ["md"] = 6,
    ["lg"] = 8
}

SHADCN.Config.Animations = CreateClientConVar("shadcn_enable_animations", "1", true, false, "Do you need to show the ui animation or not?", 0, 1)
SHADCN.Config.HighQualityRounds = CreateClientConVar("shadcn_high_quality_rounds", "1", true, false, "Do you need to draw quality rounded corners or use a picture replacement?", 0, 1)
SHADCN.Config.AnimationsSpeed = CreateClientConVar("shadcn_animations_speed", "1", true, false, "How much would you like to speed up the animations?", 0.5, 10)