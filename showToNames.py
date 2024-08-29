import os
from torrentool.api import Torrent

torrents = os.listdir('/home/a374377/.config/transmission-daemon/torrents')
torrents = filter(lambda x: x.endswith('.torrent'), torrents)

for t in torrents:
    torrent = Torrent.from_file('/home/a374377/.config/transmission-daemon/torrents/' + t)
    print(t + "-" + torrent.name)

# torrent = Torrent.from_file('/home/a374377/.config/transmission-daemon/torrents/0312805fa82369c59eae8d30ec6e6d57a3aae51d.torrent')
# print(torrent.name)
