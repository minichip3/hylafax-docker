#!/bin/bash

# 파일이 저장된 경로를 지정합니다 (큐 디렉토리).
DIRECTORY="/tmp/faxsend"

# 지원되는 파일 확장자 (pdf, tif, tiff)
for file in "$DIRECTORY"/*.{pdf,tif,tiff}; do
    # 파일이 없을 경우 루프를 빠져나갑니다.
    [ -e "$file" ] || continue

    # 파일이름에서 전화번호(확장자 제외) 추출
    filename=$(basename -- "$file")
    phone_number="${filename%%.*}"

    # sendfax 명령어 실행
    echo "Sending fax to $phone_number using file $file..."
    sendfax -n -d "$phone_number" "$file"

    # 팩스 전송 후 성공 시 파일 삭제
    if [ $? -eq 0 ]; then
        echo "Fax sent successfully to $phone_number. Deleting file $file..."
        rm "$file"  # 파일 삭제
    else
        echo "Failed to send fax to $phone_number. File $file not deleted."
    fi
done
