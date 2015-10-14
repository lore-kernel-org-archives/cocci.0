From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 14 Oct 2015 23:04:51 +0200
Subject: [Cocci] Request 339055 commented by jengelh (submit
 devel:tools/coccinelle)
In-Reply-To: <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
References: <obs-request-339055@build.opensuse.org>
 <561ec27032c86_2e7132ba18787fc@build.opensuse.org>
Message-ID: <20151014210450.GI14464@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 14, 2015 at 11:00:32PM +0200, Jan Engelhardt wrote:
> Visit https://build.opensuse.org/request/show/339055
> 
> Jan Engelhardt wrote in request 339055:
> 
> Why is this even needed? Are changes planned to the implicitly-installed packages in prjconf?

Not sure what you mean. The coccinelel build as of today uses the
concept of bundles and that requires tar to unpack things. Other
than this in the future I don't expect ./configure to be redistributed
but rather ./autogen will be required as with other software projects
to keep history clean, and since autotools is prevalent on build
systems these days anyway.

  Luis
