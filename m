From: eric@regit.org (Eric Leblond)
Date: Fri, 02 Aug 2013 11:32:27 +0200
Subject: [Cocci] Question on expression meaning
Message-ID: <1375435947.11948.89.camel@ice-age.regit.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm trying to achieve the following:

void DecodeIPV6(ThreadVars *tv, DecodeThreadVars *dtv, Packet *p, uint8_t *pkt, uint16_t len, PacketQueue *pq)
{
...
    /* now process the Ext headers and/or the L4 Layer */
    switch(IPV6_GET_NH(p)) {
        case IPPROTO_TCP:
            IPV6_SET_L4PROTO (p, IPPROTO_TCP);
-            return DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN, IPV6_GET_PLEN(p), pq);
+	      DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN, IPV6_GET_PLEN(p), pq);
+            return;

DecodeTCP being a function returning void too. In fact Solaris compiler
does not accept void function to return a void function.

My first try was:

@@
identifier f;
identifier g;
@@

void f(...)
{
...
- return g(...);
+ g(...);
+ return;
...
}

But this does not work because the ... can not be put on - + lines.

I've tried the not specific semantic patch:

@@
identifier f;
expression E;
@@

void f(...)
{
...
- return E;
+ E;
+ return;
...
}

But it does not work for function (it works for "return 42;"). Any idea ?

BR,
--
Eric
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: This is a digitally signed message part
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130802/f03fb3e2/attachment.asc>
