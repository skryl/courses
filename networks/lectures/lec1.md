# Intro to Networks

## Reading
*  1-1 Goals and Motivation. None.
*  1-2 Uses of Networks. §1.1, loosely. 
*  1-3 Network Components. §1.2, loosely. 
*  1-4 Sockets. §1.3.4, and §6.1.2-6.1.4. “Beej’s Guide to Network Programming” 
*  1-5 Traceroute. None. Many online pages and resources, e.g., Wikipedia, describe it. 
*  1-6 Protocols and Layers. §1.3 
*  1-7 Reference Models. §1.4, §1.6 
*  1-8 History of the Internet. §1.5.1 
*  1-9 Lecture Outline. None. 

## Exponential Value
- The value of a network is proportional to its interconnectivity and
  exponential with respect to the number of nodes. Doubling the size of a
  network will more than double it's connectivity and value.

## Sockets
- An OS-level API for network access
- Part of all major OSes since '83'
- Supports two kinds of services
  - Streams
  - Datagrams
- Ports allow multiplexing multiple apps on the same host

### Call Sequence
+ - blocking call

1. Connect
  * Server - socket(), bind(), listen(), +accept()
  * Client - socket(), +connect()
2. Client Send
  * Client - send()
  * Server - +recv()
3. Server Send
  * Server - send()
  * Client - +recv()
4. Close
  * Client/Server - close()

#### Client Program
1. socket()      // make socket
2. getaddrinfo() // servername lookup
3. connect()     // connect to server
4. ...
5. send()        // send request
6. +recv()        // await reply
7. ...
8. close()       // done, disconnect

#### Server Program
1. socket()      // make socket
2. getaddrinfo() // for port on this host
3. bind()        // associate port with socket
4. listen()      // prepare to accept connections
5. +accept()      // wait for connection
6. ...
7. +recv()        // await request
8. ...
9. send()        // send reply
10. close()       // done, disconnect

## Protocols and Layers
- Allows abstraction and reuse of networking components
- Protocols are stacked vertically, using only the protocols defined lower in
  the stack
- Lower layer wraps higher layer content, adding its own information to make a
  new message for delivery
- Each layer includes control information to identify the higher layer during
  demultiplexing by the receiving host

### Disadvantages
- Minor overhead
- Information hiding, the app (higher layer) might care about the type of
  network it's running on (wifi or ethernet) 

### Reference Models (what functionality in which layer)

#### OSI '7 layer' Model (not used much in practice)
7. Application  - functions needed by users
6. Presentation - converts different presentations
5. Session      - manages task dialogs
4. Transport    - provides end to end delivery
3. Network      - packets over multiple links
2. Data Link    - sends frames of information
1. Physical     - bits as signals

#### Internet Reference Model (from experience)
4. Application - programs that use network service (7)
3. Transport   - provides end to end data delivery (4)
2. Internet    - send packets over multiple networks (3)
1. Link        - send frames over a link (1,2)

#### Protocols in each layer
4. Application - HTTP, RTP, SMTP, DNS
3. Transport   - TCP, UDP
2. Internet    - IP (the narrow waist of the internet)
1. Application - 3G, Ethernet, DSL, Cable, 802.11

#### Units of Information
4. Application - Message
4. Transport   - Segment
3. Network     - Packet
2. Link        - Frame
1. Physical    - Bits

## History

### Pre-ARPANET (1960s)
- Packet switching, decentralized control

### ARPANET (1970s)
- Motivated for resource sharing
- Frist "killer app" was email
- Internetworking became the basis for the Internet (later became TCP/IP)

### NSFNET (1985s) 
- educational networks (non military)
- initially connected supercomputers
- became the backbone for all internet traffic
- classic protocols emerged (TCP/IP, DNS, Sockets)
- campuses, businesses, then homes
- 1 million hosts by 1993
- heirarchial, with NSFNET as the backbone
- 56kbps in '85, 1.5mbps in '88, 45mbps in '91

### Modern Internet (1990s) 
- after 1995, connectivity is provided by large ISPs who compete
- ISPs connect at IXP (internet exchange point) facilities
- the Web bursts on the scene in 1993
- growth lead to CDNs and ICANN in 1998



