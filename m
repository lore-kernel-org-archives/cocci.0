From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 4 Dec 2015 12:31:02 +0100
Subject: [Cocci] how to find missing initializer
In-Reply-To: <alpine.DEB.2.10.1512032310280.2777@hadrien>
References: <56603DC3.8040609@hurleysoftware.com>
 <56608E06.9060003@metafoo.de> <alpine.DEB.2.10.1512032310280.2777@hadrien>
Message-ID: <56617976.9040405@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> @r1@
>> identifier fops;
>> identifier fn;
>> position p;
>> @@
>> struct tty_operations fops at p = {
>>     ...,
>>     .cleanup = fn,
>>     ...
>> };
> 
> You don't need the ...

I find it interesting that you suggest to omit the use of SmPL ellipsis here.


> Coccinelle is very relaxed about matching structure initializers.

Would you like to explain the handling of designated initialisers
with the semantic patch language a bit more?

Regards,
Markus
