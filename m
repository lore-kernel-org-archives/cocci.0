From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 05 Mar 2013 10:55:49 +0100
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <alpine.DEB.2.02.1303051028450.1954@hadrien>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
 <5135B8DB.30307@users.sourceforge.net>
 <alpine.DEB.2.02.1303051028450.1954@hadrien>
Message-ID: <5135C125.6070707@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> No, we don't have the resources for that.

It is a pity. - I assume that some users would be interested in more interface
descriptions. Will other software developers eventually help with documentation
improvements?


>> Which approach do you recommend to assign file names and include
>> parameters to different configuration variables for your source files
>> (excluding external software components)?
> 
> No idea what this means.

The file search gave unwanted results when I attempted it with the complete
project hierarchy. I imagine that usable file name lists can be automatically
generated if all your own source files (excluding bundled components) would be
stored in specific subdirectories. Several parts can be concatenated to achieve
the desired parameters for the call of the tool "ocamldoc".

Regards,
Markus
