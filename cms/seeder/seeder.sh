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

# ----- institutions -----
post_institution() {
  return
  local name="$1"
  local address="$2"
  local phone="$3"
  local website_url="$4"
  local needs_url="$5"
  local description="$6"
  local image="./assets/institutions/$7"

  # Upload image and get the image ID
  image_id=$(curl -X POST -F "files=@$image" "$HOST/upload" | jq -r '.[0].id')

  # Post pattern data including the image ID
  curl -X POST -H "Content-type: application/json" "$HOST/institutions" -d "{\"data\": {\"name\": \"$name\", \"address\": \"$address\", \"phone\": \"$phone\", \"website_url\": \"$website_url\", \"needs_url\": \"$needs_url\", \"description\": \"$description\", \"image\": \"$image_id\"}}"
  echo -e "\n"
}

post_institution "あにまる保護施設" "大阪府大阪市旭区高殿2-21-11-5" "222-2222-2222" "https://nyannyan.com" "https://www.amazon.co.jp/" "あにまる保護施設は、動物の保護施設です。" "anitection.png"

# ----- users -----
post_user() {
  return
  local username="$1"
  local email="$2"
  local password="$3"
  local icon="./assets/users/$4"
  local region="$5"

  # Upload image and get the image ID
  icon_id=$(curl -X POST -F "files=@$icon" "$HOST/upload" | jq -r '.[0].id')

  # Post pattern data including the image ID
  curl -X POST -H "Content-type: application/json" "$HOST/auth/local/register" -d "{\"username\": \"$username\", \"email\": \"$email\", \"password\": \"$password\", \"icon\": \"$icon_id\"}"
  echo -e "\n"
}

post_user "hoge" "hoge@hoge.jp" "hogehoge" "icon.png" "大阪府"

# ----- employees -----
post_employee() {
  return
  local institution_id="$1"
  local user_id="$2"

  # Post pattern data including the image ID
  curl -X POST -H "Content-type: application/json" "$HOST/employees" -d "{\"data\": {\"institution\": \"$institution_id\", \"user\": \"$user_id\"}}"
  echo -e "\n"
}

post_employee 1 1

# ----- animals -----
post_animal() {
  return
  local images="$1"
  local name="$2"
  local age="$3"
  local gender="$4"
  local personality="$5"
  local interest="$6"
  local description="$7"
  local animal_kind="$8"
  local institution="$9"
  local avatar_icon="${10}"
  local real_icon="${11}"
  local hair_length="${12}"
  local size="${13}"
  local pattern="${14}"
  local pedigree="${15}"

  # Upload image and get the image ID
  images_id=$(curl -X POST -F "files=@$images" "$HOST/upload" | jq -r '.[0].id')
  avatar_icon_id=$(curl -X POST -F "files=@$avatar_icon" "$HOST/upload" | jq -r '.[0].id')
  real_icon_id=$(curl -X POST -F "files=@$real_icon" "$HOST/upload" | jq -r '.[0].id')

  # Post pattern data including the image ID
  curl -X POST -H "Content-type: application/json" "$HOST/animals" -d "{\"data\": {\"images\": \"$images_id\", \"name\": \"$name\", \"age\": \"$age\", \"gender\": \"$gender\", \"personality\": \"$personality\", \"interest\": \"$interest\", \"description\": \"$description\", \"animal_kind\": \"$animal_kind\", \"institution\": \"$institution\", \"avatar_icon\": \"$avatar_icon_id\", \"real_icon\": \"$real_icon_id\", \"hair_length\": \"$hair_length\", \"size\": \"$size\", \"pattern\": \"$pattern\", \"pedigree\": \"$pedigree\"}}"
  echo -e "\n"
}

post_animal "./assets/animals/image.png" "あるる" "3" "male" "人懐っこい" "ねこじゃらし" "あるるは、人懐っこい猫です。" "2" "1" "./assets/animals/avatar_icon.png" "./assets/animals/real_icon.png" "短め" "普通" "13" "1"