From: joe@perches.com (Joe Perches)
Date: Sat, 16 Aug 2014 13:06:56 -0700
Subject: [Cocci] cocci: char* indexing style for linux
Message-ID: <1408219616.2683.101.camel@joe-AO725>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi.

I tried this:

$ spatch --version
spatch version 1.0.0-rc21 without Python support and with PCRE support

$ cat char_index.cocci
@@
unsigned char * foo;
expression e;
@@

-	*(foo + e)
+	foo[e]

@@
char * foo;
expression e;
@@

-	*(foo + e)
+	foo[e]

$

with

$ spatch --recursive-includes -sp-file char_index.cocci drivers/net/ethernet/intel/e1000/e1000_ethtool.c

and got (after a very long time)

diff = 
--- drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ /tmp/cocci-output-31725-95778b-e1000_ethtool.c
@@ -1395,9 +1395,9 @@ static int e1000_check_lbtest_frame(stru
 				    unsigned int frame_size)
 {
 	frame_size &= ~1;
-	if (*(skb->data + 3) == 0xFF) {
-		if ((*(skb->data + frame_size / 2 + 10) == 0xBE) &&
-		   (*(skb->data + frame_size / 2 + 12) == 0xAF)) {
+	if (skb->data[3] == 0xFF) {
+		if ((skb->data + frame_size / 2[10] == 0xBE) &&
+		   (skb->data + frame_size / 2[12] == 0xAF)) {
 			return 0;
 		}
 	}
Note: processing took   51.2s: drivers/net/ethernet/intel/e1000/e1000_ethtool.c
$

(originally I used spatch version 1.0.0-rc14,
 it took > 300 seconds, so that's improvement)

The suggested conversion to "sk->data + frame_size / 2[10]"
is not correct.

Can I make the char * foo test match the shortest
match or the statement s match the longest match
somehow?

I tried it with --disable-multi-pass and got the same
suggestion.

Is there another magic incantation?

cheers, Joe
