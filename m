From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 16 Nov 2016 14:45:50 +0100
Subject: [Cocci] SmPL script construction with included files
In-Reply-To: <alpine.DEB.2.10.1611161350550.3153@hadrien>
References: <3c65eb92-8be0-be42-bf8e-893f3853df12@users.sourceforge.net>
 <alpine.DEB.2.20.1611152248150.2060@hadrien>
 <32639cf9-b644-0230-02a6-88d66925340e@users.sourceforge.net>
 <alpine.DEB.2.10.1611161152570.3153@hadrien>
 <6810eb15-839c-8aa5-6485-401d43ba1246@users.sourceforge.net>
 <alpine.DEB.2.10.1611161350550.3153@hadrien>
Message-ID: <69c3643e-10b4-007a-f847-d0098f298e16@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


>> I am looking for ways to avoid source code duplication by inclusion of
>> other files.
>> Would it make sense to allow the use of an include statement within the
>> SmPL variable definition block of a rule?
> I have the impression that what you want would be adequately implemented
> by a virtual identifier that could be tested in the code or by a virtual rule.

These syntax elements will fit also to some use cases.


> For example, the semantic patches in the Linux kernel provide alternate
> implementations depending on whether one uses the arguments -D patch, -D context, etc.

These parameters have got an influence on rule dependencies.

I am thinking about an other use case a bit more where I have got a few
SmPL script templates which are working to some degree. If I would like
to use also the functionality ?Script constraints on meta-variables?
(instead of a big regular expression) for a function name selection on
demand there, I am going to recombine existing pieces by a corresponding
make script as a kind of preprocessing step.

Regards,
Markus
