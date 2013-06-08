From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 8 Jun 2013 19:28:53 +0200
Subject: [Cocci] Removing pointer declaration
Message-ID: <20130608172853.GA2997@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

This spatch:

@@
int *p;
@@

-	int *p;

with this code:


int main()
{
	int *a;

	return 0;
}

results in:

Fatal error: exception Failure("minus: parse error: 
 = File "test.cocci", line 5, column 7,  charpos = 22
    around = 'p', whole content = -	int *p;
")

using:

spatch version 1.0.0-rc15 with Python support and with PCRE support
(although dpkg says it is rc16)

Am I doing something wrong?

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130608/353b5d59/attachment.asc>
