From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 21 Jun 2014 08:50:54 +0200
Subject: [Cocci] SmPL for automatic request_firmware_nowait() conversion
In-Reply-To: <20140621015714.GX4841@wotan.suse.de>
References: <20140621015714.GX4841@wotan.suse.de>
Message-ID: <53A52B4E.20807@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Obviously I considered writing SmPL for this, but one thing which seemed
> hard was that for after the request_firmware_nowait() we tend to tuck
> away into another new call the rest of the code that was in place in the
> original function after the old request_firmware() call. Is there a way
> to dump all that code into the new routine?

Does the refactoring "Extraction of an interface" fit also to your use case?
http://refactoring.com/catalog/extractInterface.html
http://c2.com/cgi/wiki?ExtractInterface


> I think the hardest thing would be to also move the right set of variables over.

The current syntax for semantic patches has got some limitations for its
expression power. I guess that it is still a software development challenge to
support also variations in involved statements.


> Its hard for me to think of how I can hint to Coccinelle enough information
> about what stuff it needs to move around. I think one hint would be:
> 
>   "Hey all that code that is static and is used *before* and *after* request_firmware()
>    stuff it into the private data structure"

Do you need dynamic source code introspection here?

Regards,
Markus
