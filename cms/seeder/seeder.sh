#!/bin/bash
HOST='https://anitection-strapi.yumekiti.net/api'


# ----- animal-kinds -----
post_animal_kind() {
  return
  local kind="$1"
  curl -X POST -H "Content-type: application/json" "$HOST/animal-kinds" -d "{\"data\": {\"name\": \"$kind\"}}"
  echo -e "\n"
}

post_animal_kind "犬"
post_animal_kind "猫"


# ----- pedigrees -----
post_pedigree() {
  return
  local name="$1"
  local image="./assets/pedigrees/$2"

  # Upload image and get the image ID
  image_id=$(curl -X POST -F "files=@$image" "$HOST/upload" | jq -r '.[0].id')

  # Post pedigree data including the image ID
  curl -X POST -H "Content-type: application/json" "$HOST/pedigrees" -d "{\"data\": {\"name\": \"$name\", \"image\": \"$image_id\"}}"
  echo -e "\n"
}

post_pedigree "トイプードル" "toy-poodle.png"
post_pedigree "チワワ" "chihuahua.png"
post_pedigree "ポメラニアン" "pomeranian.png"
post_pedigree "ヨークシャテリア" "yorkshire-terrier.png"
post_pedigree "ブルドッグ" "bulldog.png"
post_pedigree "シーズー" "shih-tzu.png"
post_pedigree "コーギー" "corgi.png"
post_pedigree "柴犬" "shiba.png"
post_pedigree "ダックスフンド" "dachshund.png"
post_pedigree "パグ" "pug.png"
post_pedigree "パピヨン" "papillon.png"


# ----- animal-kinds relation -----
put_animal_kind_relation() {
  return
  local kind_id="$1"
  local pedigree_ids="$2"

  # Post pedigree data including the image ID
  curl -X PUT -H "Content-type: application/json" "$HOST/animal-kinds/$kind_id" -d "{\"data\": {\"pedigrees\": $pedigree_ids}}"
  echo -e "\n"
}

put_animal_kind_relation 1 "[1,2,3,4,5,6,7,8,9,10]"


# ----- patterns -----
post_pattern() {
  return
  local name="$1"
  local image="./assets/patterns/$2.png"

  # Upload image and get the image ID
  image_id=$(curl -X POST -F "files=@$image" "$HOST/upload" | jq -r '.[0].id')

  # Post pattern data including the image ID
  curl -X POST -H "Content-type: application/json" "$HOST/patterns" -d "{\"data\": {\"name\": \"$name\", \"image\": \"$image_id\"}}"
  echo -e "\n"
}

post_pattern "白地×全身" "white_solid"
post_pattern "黒地×全身" "black_solid"
post_pattern "グレー×全身" "gray_solid"
post_pattern "茶トラ×全身" "brown_tabby_solid"
post_pattern "キジトラ×全身" "tortoiseshell_solid"
post_pattern "サバトラ×全身" "silver_tabby_solid"
post_pattern "サビ地×全身" "red_solid"
post_pattern "白黒" "black_and_white"
post_pattern "グレー白" "gray_and_white"
post_pattern "茶白" "brown_and_white"
post_pattern "キジ白" "tortoiseshell_and_white"
post_pattern "サバ白" "silver_and_white"
post_pattern "ミケ" "calico"
post_pattern "白黒トビ" "tuxedo"
post_pattern "グレートビ" "gray_tuxedo"
post_pattern "茶白トビ" "brown_and_white_tuxedo"
post_pattern "トビキジ" "tortoiseshell_tuxedo"
post_pattern "サバ白トビ" "silver_and_white_tuxedo"
post_pattern "トビミケ" "calico_tuxedo"
post_pattern "クリーム" "cream"
post_pattern "グレートラ" "gray_cream"
post_pattern "パステルミケ" "dilute_calico"
post_pattern "グレーサビ" "dilute_silver_tabby"

# ----- animal-kinds relation -----
put_animal_kind_relation() {
  return
  local kind_id="$1"
  local pattern_ids="$2"

  # Post pedigree data including the image ID
  curl -X PUT -H "Content-type: application/json" "$HOST/animal-kinds/$kind_id" -d "{\"data\": {\"patterns\": $pattern_ids}}"
  echo -e "\n"
}

put_animal_kind_relation 2 "[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]"