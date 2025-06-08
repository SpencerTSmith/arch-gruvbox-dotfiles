#!/usr/bin/env bash

messages=(
  # GENERIC/BIBLE/ETC
  "AD MELIORA"
  "NIHIL SUB SOLE"
  "REMEMBER, YOU WILL DIE"

  # CAESAR
  "ALEA IACTA EST"

  # NIETZSCHE
  "MONSTRUM IN FRONTE, MONSTRUM IN ANIMO"
  "AMOR FATI"
  "TYRANTS OF THE SPIRIT"
  "MISERABLE, EPHEMERAL RACE, CHILDREN OF HAZARD AND HARDSHIP"
  "WE SHOULD SHUDDER, IF WE WERE EVER TO UNDERSTAND THEM 'IN GREEK'"
  "A TIGERISH LUST TO ANNIHILATE"
  "CURIOUS TO A VICE, INVESTIGATORS TO THE POINT OF CRUELTY"
  "GRATEFUL TO GOD, DEVIL, SHEEP, AND WORM IN US"
  "GRATEFUL TO GOD, DEVIL, SHEEP, AND WORM IN US"

  # MILTON
  "AND JUSTIFY THE WAYS OF GOD TO MAN"
  "SEE HOW IN WARLIKE MUSTER THEY APPEAR"
  "THEY HAND IN HAND WITH WAND'RING STEPS AND SLOW"
  "THROUGH EDEN TOOK THEIR SOLITARY WAY"
  "IF THEY LIKE OUR OVERTURE, AND TURN NOT BACK PERVERSE"
  "A DARK ILLMITABLE OCEAN WITHOUT BOUND"

  # THUCYDIDES
  "A POSSESSION FOR ALL TIME"
  "IN THE FORTUNE OF A SINGLE MOMENT, AT THE CLIMAX OF GLORY NOT OF FEAR, THEY PASSED AWAY"
  "WHEN STRUCK DOWN IN THE FULL FLOWER OF HIS STRENGTH"
  "BUT, WAR IS A VIOLENT MASTER"

  # CALLICLES, first is a quotation of PINDAR
  "BRINGS ON AND RENDERS JUST WHAT IS MOST VIOLENT"
  "HE WILL SHAKE OFF, TEAR APART, AND ESCAPE ALL THIS"
  "HE WILL TRAMPLE UNDERFOOT OUR DOCUMENTS, OUR TRICKS AND CHARMS, AND ALL OUR LAWS THAT VIOLATE NATURE"

  # TENNYSON
  "ALL TIMES I HAVE ENJOY'D GREATLY, HAVE SUFFER'D GREATLY"
  "I WILL DRINK LIFE TO THE LEES"
  "TO STRIVE, TO SEEK, TO FIND, AND NOT TO YIELD"
  "TO FOLLOW KNOWLEDGE LIKE A SINKING STAR"
  "TO RUST UNBURNISH'D, NOT TO SHINE IN USE"

  "IF I MUST SUFFER, THEN LET IT BE FROM MY REALITY"
  "THEY REFUSE TO PAY LIFE'S DUES"

  "COMMON SENSE WILL NOT ACCOMPLISH GREAT THINGS, SIMPLY BECOME INSANE AND DESPERATE"
)

colors=(
    "\033[1;91m"  # Bright Bold Red
    "\033[1;92m"  # Bright Bold Green
    "\033[1;93m"  # Bright Bold Yellow
    "\033[1;94m"  # Bright Bold Blue
    "\033[1;95m"  # Bright Bold Magenta
    "\033[1;96m"  # Bright Bold Cyan
)
color_reset="\033[0m"
color_bold_white="\033[1;97m"

random_index=$((RANDOM % ${#messages[@]}))
message="${messages[$random_index]}"

random_index=$((RANDOM % ${#colors[@]}))
color="${colors[$random_index]}"

message_length=${#message}

border_length=$((message_length + 8))
border=$(printf '%*s' "$border_length" | tr ' ' '~')

terminal_width=$(tput cols)

padding_left=$(( (terminal_width - border_length) / 2 ))
padding=$(printf '%*s' "$padding_left" "")

echo -e "${padding}${color_bold_white}${border}${color_reset}"
echo -e "${padding}    ${color}${message}${color_reset}"
echo -e "${padding}${color_bold_white}${border}${color_reset}"
