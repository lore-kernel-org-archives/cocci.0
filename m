From: more.andres@gmail.com (=?ISO-8859-1?Q?Andr=E9s_More?=)
Date: Tue, 12 Mar 2013 10:51:49 -0300
Subject: [Cocci] how to consider castings in semantic patchs
Message-ID: <CAHCmPpPznDVsBwcPVhgrBwq1ejBt7i7U8WDj3+iCoBjsBnGm4Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, I've been playing with Coccinele, I find it really useful.

I'm trying to create a semantic patch to rename a structure (and its
fields).
I could get almost everything in place in several patches: the structure
gets renamed, also variables of that type, also their attributes. However,
the code (not mine) uses some explicit castings and I couldn't find a way
to cover those cases also.

I've tried to follow the documented grammar but I think I got lost without
finding how to declare such castings.

I'm appending the last version of the semantic patch I've been working on
just to give the rough idea how what I am trying to describe. The code is a
Linux kernel staging driver (VIA VT6656), using their own Ethernet packet
struct.

Thanks, I will really appreciate any hints on how to consider explicit
casting.

-- Andres

Sample Line not covered
pMACHeader = (PS802_11Header) (pbyRxBufferAddr + cbHeaderSize);

Semantic patch I could get done
$ cat test.cocci
@rule1@
identifier h;
@@
-PSEthernetHeader h;
+struct ethhdr * h;

@rule2@
identifier h;
@@
-PS802_11Header h;
+struct ieee80211_hdr *h;

@rule5@
identifier h;
@@
-SEthernetHeader h;
+struct ethhdr h;

@rule6@
identifier h;
@@
-S802_11Header h;
+struct ieee80211_hdr h;

@rule3@
struct ethhdr *h;
@@
(
-h->abyDstAddr
+h->h_dest
|
-h->abySrcAddr
+h->h_source
|
-h->wType
+h->h_proto
)

@rule4@
struct ieee80211_hdr *h;
@@
(
-h->wFrameCtl
+h->frame_control
|
-h->wDurationID
+h->duration_id
|
-h->abyAddr1
+h->addr1
|
-h->abyAddr2
+h->addr2
|
-h->abyAddr3
+h->addr3
|
-h->wSeqCtl
+h->seq_ctrl
|
-h->abyAddr4
+h->addr4
)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130312/497e76ed/attachment.html>
