From: Andrei.Drimbarean@analog.com (Drimbarean, Andrei)
Date: Wed, 3 Jan 2018 15:50:41 +0000
Subject: [Cocci] Changing the name of a structure
Message-ID: <BDBE27321C1A364E9AB0CBE6FF1FAEE18912F6@NWD2MBX6.ad.analog.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Thank you for the swift response on issue #128. It worked using the pointers you gave me:

>Another small point, The Linux kernel frowns on typedefs for structs. So
>really you want to turn it into
>
>struct example
>char me;
>long you;
>} struct_example;
>
>int main (void) {
>struct example *DeV;
>...
>}

Thank you!

Andrei
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180103/35eb194f/attachment.html>
