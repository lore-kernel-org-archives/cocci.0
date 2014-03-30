From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 30 Mar 2014 15:08:36 +0200
Subject: [Cocci] Improvements for source code analysis with inclusion of
 header files
In-Reply-To: <alpine.DEB.2.10.1403301445260.2092@hadrien>
References: <5338004F.3090303@users.sourceforge.net>
 <alpine.DEB.2.10.1403301354280.2092@hadrien>
 <53380A7D.9060005@users.sourceforge.net>
 <alpine.DEB.2.10.1403301425110.2092@hadrien>
 <53380F07.9020500@users.sourceforge.net>
 <alpine.DEB.2.10.1403301434580.2092@hadrien>
 <533811B2.4020109@users.sourceforge.net>
 <alpine.DEB.2.10.1403301445260.2092@hadrien>
Message-ID: <53381754.3080204@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Do you distinguish headers from source files in this use case?
> 
> No that I recall.

Would you like to support any variant of precompiled header files?


> The software changes, or one wants to use Coccinelle with other options,
> and then one would rather start over with a new cache.

I imagine that caches can also be generated for data representations with a
longer "life time".


> In that case, I usually limit the size of the cache as well, because the format
> is not particularly concise.  This further implies that it is not useful
> to anything other than the current run.

I am becoming a bit more interested in conciseness for relevant data structures.
How can it be achieved to make the intermediate data storage useful for several
different source code analysis runs?

Regards,
Markus
