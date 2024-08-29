import mailbox
from tqdm import tqdm
import re
import os

mbx = mailbox.Maildir('~/.mail/gmail/Inbox')
document_path = os.path.expanduser('~/Documents/Izzi/')

for msg in tqdm(mbx):
    if(re.search("^izzi, estado de cuenta.*", str(msg['subject']))):
        filename = msg.get_payload()[1]['Content-Type'].split('name=')[1].replace('"', '')
        filepath = document_path + filename
        file = msg.get_payload()[1]

        if(os.path.exists(filepath)):
            print(filename + " already exists. Skipping...")
            continue

        print("Saving " + filename + "...")
        pdf = open(filepath, 'wb')
        pdf.write(file.get_payload(decode=True))
        pdf.close()
