From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Nov 2016 12:14:42 +0100
Subject: [Cocci] SmPL script construction with several initialisation
 parts
In-Reply-To: <alpine.DEB.2.20.1611152305520.2060@hadrien>
References: <4633253e-3d59-edef-5778-b6f235fb9340@users.sourceforge.net>
 <alpine.DEB.2.20.1611152250050.2060@hadrien>
 <10be3d5f-35ff-2a0e-2e51-b4c96b8ca20c@users.sourceforge.net>
 <alpine.DEB.2.20.1611152305520.2060@hadrien>
Message-ID: <bbca8d62-4ca6-77d1-b7cf-515f33bb65de@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>>> Can such initialisation code be constructed by the specification of several
>>>> script parts there?
>>> I don't understand the question.
>> I suggest to consider corresponding design consequences again.
>>
>>
>>> If the script language supports includes, then you can put includes in the script code.
>> I imagine that it will be occasionally nicer to avoid the indirect inclusion
>> of another file there.
>> When will it be more consistent to construct an initialisation script
>> by your host programming language?
> No idea what you mean.

Is it easier for you to clarify the use case based on a concrete source
code example from the recent development ?Script constraints on
meta-variables??
https://github.com/coccinelle/coccinelle/blob/cbc751b30d9e02390d60ebed643c8e4a3fa0bb2b/tests/idcon_python.cocci#L1

If I would like to switch between two constraint specifications there
for a function name list selection in a bigger SmPL script template, I
am looking for a convenient way to append another bit of initialisation
code.

Regards,
Markus
