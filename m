From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 24 Aug 2017 11:50:06 +0200
Subject: [Cocci] parsing of C code
In-Reply-To: <alpine.DEB.2.20.1708222304510.2050@hadrien>
References: <alpine.DEB.2.20.1708222304510.2050@hadrien>
Message-ID: <fc1a0561-29c5-f386-246b-9718882d8355@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I have tried to improve the parsing of C code recently.

This information is useful.


> 1.  More aggressive inclusion of header files,

Why do you need to become ?aggressive? there when the corresponding
data processing should be just correct?


> combined with caching of header files.

How do you think about to configure this approach with special parameters?


> flush stdout

Can such a function call be omitted here?


> If some functions are missing in the output when using the new version,
> as compared to the output when using the old version, and if these functions
> are things you might want to process in some way, thenlet me know about
> the problem.

I became more curious on the run time characteristics (as you already know)
for the presented software evolution. I stumbled on some execution challenges
during the application of special source code search patterns.
How would they increase because of the desired inclusion of additional
source (or header) files for analysis approaches which would need them?

Regards,
Markus
