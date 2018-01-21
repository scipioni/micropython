"""
curl -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" -d "chat_id=${CHATID}&text=${*}"
"""

import urequests

TOKEN="341350121:AAF8fpXpS-LZlKgMHj1R1PJLLde60ylT7Mc"
CHATID="73496590"
URL="https://api.telegram.org/bot{}/sendMessage"

response = urequests.post( URL.format(TOKEN), 
    json={'chat_id': CHATID, 'text': 'hello friend'}
    ).json()
print(response)

