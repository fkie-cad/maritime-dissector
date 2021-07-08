# Wireshark Dissector for Maritime Protocols

This is a lua plugin for Wireshark which contains dissectors for the following maritime protocols:
- IEC 61162-450 (Lightweight Ethernet)
- NMEA over IP (with sentences defined in NMEA 0183) sent over UDP

The plugin was primarily developed by Merlin von Rechenberg while working at Fraunhofer FKIE.

## Screenshot

![screenshot](docs/450-dissector-screenshot.png)

## Dependencies

The plugin is written in lua and uses lua5.2 or higher, which is by default shipped with Wireshark.
No dependencies other than Wireshark are needed to use this plugin.
It can also be used with TShark instead of Wireshark.
For this lua5.2 (or higher) has to be installed manually because TShark does not include a lua interpreter.

## Quick Start

*Note*: The automated installation script only works for Unix-like systems.
For other systems please follow the instructions of [Manual installation](#manual-installation)

Download or clone the repository, open a terminal, and navigate into the downloaded directory that includes the `install.sh` file.

Execute the installation script:
```
./install.sh
```
Follow the instructions given by the script.
It might ask for permission to create the private wireshark plugin directory if the directory does not exist yet.
If that is the case press `y` to confirm and continue.

If the script is not executable you can make it executable:
```
chmod +x ./install.sh
```

After the installation the plugin will be loaded automatically by Wireshark.
The dissectors will be used by Wireshark for all packets that match one of the included maritime protocols.

### Manual Installation

Copy all lua files of the dissector to the plugin directory of your wireshark installation.
For wireshark standard installations on Unix-like systems this is:
*~/.local/lib/wireshark/plugins*:

```shell
cp ./path-to-downloaded/maritime-dissector.lua ~/.local/lib/wireshark/plugins/
cp -r ./path-to-downloaded/maritime-modules/ ~/.local/lib/wireshark/plugins/
```

For other systems please use the plugin directories listed in the [official wireshark documentation](https://www.wireshark.org/docs/wsug_html_chunked/ChPluginFolders.html).

To load the plugin, restart Wireshark or reload lua plugins in Wireshark with (usually `ctrl+shift+l`).

## Usage

There are three dissectors included in the plugin.
The first dissector is for plain NMEA sentences as defined in NMEA-0183 contained in UDP packets (NMEA over IP).
The other two dissectors are both for IEC-61162-450 (Lightweight Ethernet) since there are two different types of IEC 61162-450 that are handled as separate protocols by this plugin.

The first of the IEC-61162-450 dissectors is for packets containing NMEA sentences nested inside IEC-61162-450.
The second of the IEC-61162-450 dissectors is for packets containing binary files or binary file fragments.

### NMEA-0183

The dissector for NMEA sentences that are contained in UDP packets as the payload dissects the following fields:

| Field Name | Field | Description |
| ------ | ------ | ------ |
| TalkerID | nmea-0183.talkerid | Talker ID as defined in NMEA-0183 |
| SentenceID | nmea-0183.sentenceid | Sentence type as defined in NMEA-0183 |
| Data | nmea-0183.data | Comma seperated nautical data contained in the sentence |
| Checksum | nmea-0183.checksum | Checksum of the sentence (Checksum8 XOR) and info if checksum is valid or corrupt |

This dissector shows an expert info if that the checksum is corrupt or if the sentence is too long.

### IEC-61162-450-NMEA

This dissector dissects the following fields of the IEC-61162-450 with header token `UdPbC` containing NMEA sentences:

| Field Name | Field | Description |
| ------ | ------ | ------ |
| Token | iec-61162-450-nmea.token | Identifies message type. For NMEA Messages this should be `UdPbC` |
| Tags | iec-61162-450-nmea.tags | Tag blocks as defined in IEC-61162-450 (`\\`-seperated strings)   |
| Sentence | iec-61162-450-nmea.sentence | NMEA-Sentence containing nautical data as defined in IEC 61162-450 and NMEA 0183 |
| NMEA 0183 | nmea-0183 | Nested dissection of the NMEA sentence using the NMEA 0183 dissector described above |

This dissector shows an expert info if any checksums are corrupt or if the length of any tags exceed the length defined in IEC 61162-450.

### IEC-61162-450-Binary

This dissector dissects the following fields of the IEC-61162-450 with header token `RrUdP`, `RaUdP` or `RpUdP` containing binary file fragments:

| Field Name | Field | Description |
| ------ | ------ | ------ |
| Token | iec-61162-450-binary.token | Identifies message type and transfer mode. For Binary File Transfer this should be `RaUdP`, `RrUdp` or `RpUdP` |
| Version | iec-61162-450-binary.version | Header version. This dissector is written for version 1 and might not work for higher versions |
| Source ID | iec-61162-450-binary.srcid | ID of the unit that sent the file |
| Destination ID | iec-61162-450-binary.destid | ID of the designated destination unit (can be `XXXXXX` if no specific destination is given) |
| Type | iec-61162-450-binary.mtype | Type of information contained: Can be 1 (data), 2 (query) or 3 (ack) |
| Block ID | iec-61162-450-binary.blockid | Identifies each binary file block that can be fragmented into several datagrams |
| Sequence Number | iec-61162-450-binary.seqnum | Number of the fragment in this datagram. Used for fragmentation and reassembly of the binary file blocks. |
| Maximum Sequence Number | iec-61162-450-binary.maxseqnum | Number of fragments that belong to this binary file block |
| First binary fragment | iec-61162-450-binary.firstpacket | Number of and link to the packet containing the first fragment and the binary file descriptor of the binary file block |
| Previous binary fragment | iec-61162-450-binary.prevpacket | Number and link to the packet containing the previous fragment |
| Next binary fragment | iec-61162-450-binary.nextpacket | Number and link to the packet containing the next fragment |

From the IEC-61162-450-Binary packets, the packet with the first binary file fragment of a whole block also contains a binary file descriptor.
The binary file descriptor has several fields which can be dissected as well.
Two fields of the IEC-61162-450-Binary Header indicate wether a packet has a binary file descriptor or not, the type, and the sequence number.
Those fields must have the following values if a binary file descriptor is present in the packet:
*  Type: `iec-61162-450-binary.mtype==1`
*  Sequence Number: `iec-61162-450-binary.seqnum==1`

If those conditions are fulfilled, the binary file descriptor will always be dissected as a nested protocol of IEC-61162-450-Binary with the following fields:

| Field Name | Field | Description |
| ------ | ------ | ------ |
| File descriptor length | binary-file-descriptor.fd_length | Length of the binary file descriptor |
| File length | binary-file-descriptor.file_length | Length of the whole file (all fragments) |
| Status of acquisition | binary-file-descriptor.stat_of_acquisition | Field for error codes (No error = 0) |
| Device | binary-file-descriptor.device| Data source device as binary value (between 1 and 255) |
| Channel | binary-file-descriptor.channel | Subdivision according to data source (device) (between 1 and 255, default = 1) |
| Type length | binary-file-descriptor.type_length | Length of data type field |
| Data type | binary-file-descriptor.data_type | String describing data type and encoding |
| Status and information text | binary-file-descriptor.stat_and_info | String(s) for additional information, null-terminated each |


## Tests

Included in this repository are automated tests for the plugin.
The purpose of those tests is to check if the plugin works as intended.
By running the tests you can also get a code coverage report.

### Requirements for the Tests

Additional dependencies are needed for the tests.
The following packages have to be installed on your system:
* `tshark`
* `python3`
* `python3-pytest`
* `lua`
* `luacov` (optional for code coverage report)
* `luacov-console` (optional for code coverage report)

On Debian-based systems you can install `tshark`, `python3`, `python3-pytest`, and `lua` like this:
```
sudo apt-get update
sudo apt-get install tshark python3 python3-pytest lua5.3
```

`luacov` and `luacov-console` can be installed through `luarocks` (https://luarocks.org/).
Those two packages are only needed for the code coverage report.
The tests can be executed without them if you do not need the coverage report.

For running the tests, the dissector should not be installed.
This means the lua files of the dissector *must not* be in the wireshark plugin directory when executing the tests.
If you have already installed the dissector before running the tests, you have to remove all lua files belonging to this dissector from the plugin directory.
For the standard installation on Unix-like systems this can be done by:
```
rm ~/.local/lib/wireshark/plugins/iec-61162-450-nmea.lua
rm ~/.local/lib/wireshark/plugins/iec-61162-450-binary.lua
rm -r ~/.local/lib/wireshark/plugins/iec-61162-450-modules
```
You can reinstall the dissector after running the tests as described in [Quick start](#quick-start).

### Running the Tests

*Important*: The tests can only be executed when the dissector is *not* installed in the plugin directory!
If you have already installed the dissector and want to run the tests, please refer to the previous section [Requirements for the tests](#requirements-for-the-tests).

When all requirements are fulfilled you can run the tests by executing the test script:
```
./tests/test.sh
```

If the script is not executable, you can make it executable:
```
chmod +x ./tests/test.sh
```

## License

This Wireshark plugin is licensed under a [supplemented MIT License](./LICENSE).
