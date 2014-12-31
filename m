From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 31 Dec 2014 15:10:51 +0100
Subject: [Cocci] Source code analysis for header files
In-Reply-To: <alpine.DEB.2.10.1412311457130.2559@hadrien>
References: <54A3F836.7060903@users.sourceforge.net>
 <alpine.DEB.2.10.1412311439380.2559@hadrien>
 <54A40032.4070904@users.sourceforge.net>
 <alpine.DEB.2.10.1412311457130.2559@hadrien>
Message-ID: <54A403EB.8080709@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>>> Can the tool "spatch" be instructed anyhow to analyse only
>>>> header files (*.h) instead of the usual source files (*.c)
>>>> after the parameter "--dir" was passed?
>>> No.
>> Thanks for your clarification.
>>
>> Will it eventually be quicker to determine the list
>> of header files by other software tools?
> Much quicker.

How do you think about an approach just to change the file
name extension from ".c" to ".h" occasionally?
Are there any more use cases around where
it makes also sense to search for source files
with other suffixes?

Regards,
Markus
