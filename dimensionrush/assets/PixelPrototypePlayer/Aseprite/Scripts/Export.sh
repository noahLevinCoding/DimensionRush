
#!/bin/bash

ASEPRITE_PATH="Aseprite"
PLAYER_PATH="../Player.aseprite"
COMBAT_PATH="../PlayerCombat.aseprite"
EFFECTS_PATH="../Effects.aseprite"
WEAPONS_PATH="../Weapons.aseprite"
PREVIEW_PATH="../../../AssetPage/PreviewAnimations.aseprite"
PLAYER_WITH_EFFECTS_PATH="../../../AssetPage/PlayerAnimationsWithEffects.aseprite"
SPRITES_FOLDER="../../Sprites/"
SPRITES_SEPARATED_FOLDER="../../SpritesSeparated/"
PREVIEW_FOLDER="../../../Preview"
PARAMS="--script-param sprites-folder=$SPRITES_FOLDER"
BACKGROUND_LAYER="Background"
REFERENCE_LAYER="Reference"
DEFAULT_PARAMS="--ignore-layer "Background" --ignore-layer "Reference" --ignore-layer "NormalMap""

display_menu() {
  echo "Please choose an option:"
  echo "1. Player"
  echo "2. Player Parts"
  echo "3. Player Combat"
  echo "4. Player Combat Parts"
  echo "5. Previews"
  echo "6. All"
  echo "7. Exit"
}

export_player() {
  echo "Exporting Player"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --save-as $SPRITES_FOLDER/{tag}/{tag}{frame01}.png --split-tags
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --sheet $SPRITES_FOLDER/PlayerSheet.png --data $SPRITES_FOLDER/PlayerSheet.json --split-tags
  echo "Exported Player"
  
  # "$ASEPRITE_PATH" -b "$PLAYER_PATH" --save-as %UNITY_PATH%/Aseprite/PlayerAnimations.aseprite
}

export_player_parts() {
  echo "Exporting Player Parts"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --layer "Player/RightArm" --save-as $SPRITES_SEPARATED_FOLDER/{tag}/RightArm/{tag}{frame01}.png
  echo "Exported Right Arm"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --layer "Player/LeftArm" --save-as $SPRITES_SEPARATED_FOLDER/{tag}/LeftArm/{tag}{frame01}.png
  echo "Exported Left Arm"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --layer "Player/Head" --save-as $SPRITES_SEPARATED_FOLDER/{tag}/Head/{tag}{frame01}.png
  echo "Exported Head"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --layer "Player/RightLeg" --save-as $SPRITES_SEPARATED_FOLDER/{tag}/RightLeg/{tag}{frame01}.png
  echo "Exported Right Leg"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --layer "Player/LeftLeg" --save-as $SPRITES_SEPARATED_FOLDER/{tag}/LeftLeg/{tag}{frame01}.png
  echo "Exported Left Leg"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$PLAYER_PATH" --layer "Player/Torso" --save-as $SPRITES_SEPARATED_FOLDER/{tag}/Torso/{tag}{frame01}.png
  echo "Exported Torso"
  echo "Exported Player Parts"
}

export_player_combat() {
  echo "Exporting Player Combat"
  # "$ASEPRITE_PATH" -b "$EFFECTS_PATH" --save-as %UNITY_PATH%/Aseprite/"$EFFECTS_PATH"
  # "$ASEPRITE_PATH" -b "$WEAPONS_PATH" --save-as %UNITY_PATH%/Aseprite/"$WEAPONS_PATH"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --save-as $SPRITES_FOLDER/Combat/{tag}/{tag}{frame01}.png --split-tags
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --sheet $SPRITES_FOLDER/PlayerCombatSheet.png --data $SPRITES_FOLDER/PlayerCombatSheet.json --split-tags
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$EFFECTS_PATH" --save-as $SPRITES_FOLDER/FX/{tag}/{tag}{frame01}.png --split-tags
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$EFFECTS_PATH" --sheet $SPRITES_FOLDER/FXSheet.png --data $SPRITES_FOLDER/FXSheet.json --split-tags
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$WEAPONS_PATH" --save-as $SPRITES_FOLDER/Weapons/{tag}/{tag}{frame01}.png --split-tags
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$WEAPONS_PATH" --sheet $SPRITES_FOLDER/WeaponsSheet.png --data $SPRITES_FOLDER/WeaponsSheet.json --split-tags
  echo "Exported Player Combat"
}

export_player_combat_parts() {
  echo "Exporting Player Combat Parts"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/RightArm" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/RightArm/{tag}{frame01}.png
  echo "Exported Right Arm"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/LeftArm" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/LeftArm/{tag}{frame01}.png
  echo "Exported Left Arm"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/Head" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/Head/{tag}{frame01}.png
  echo "Exported Head"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/RightLeg" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/RightLeg/{tag}{frame01}.png
  echo "Exported Right Leg"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/LeftLeg" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/LeftLeg/{tag}{frame01}.png
  echo "Exported Left Leg"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/Torso" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/Torso/{tag}{frame01}.png
  echo "Exported Torso"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/FX" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/FX/{tag}{frame01}.png
  echo "Exported Effects"
  "$ASEPRITE_PATH" -b $DEFAULT_PARAMS "$COMBAT_PATH" --layer "Player/Weapon" --save-as $SPRITES_SEPARATED_FOLDER/Combat/{tag}/Weapon/{tag}{frame01}.png
  echo "Exported Weapon"
  echo "Exported Exported Player Combat Parts"
}

export_preview() {
  echo "Exporting Previews"
  "$ASEPRITE_PATH" -b "$PREVIEW_PATH" --scale 2 --save-as $PREVIEW_FOLDER/PreviewAnimations.gif
  "$ASEPRITE_PATH" -b "$PLAYER_WITH_EFFECTS_PATH" --scale 2 --save-as $PREVIEW_FOLDER/{tag}.gif
  echo "Exported Previews"
}

while true; do
  display_menu
  read -p "Enter your choice [1-7]: " choice

  case $choice in
    1)
      export_player
      ;;
    2)
      export_player_parts
      ;;
    3)
      export_player_combat
      ;;
    4)
      export_player_combat_parts
      ;;
    5)
      export_preview
      ;;
    6)
      export_player
      export_player_parts
      export_player_combat
      export_player_combat_parts
      export_preview
      ;;
    7)
      echo "Exiting..."
      break
      ;;
    *)
      echo "Invalid option. Please try again."
      ;;
  esac

  echo ""
done