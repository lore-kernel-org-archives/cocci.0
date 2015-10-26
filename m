From: mmarek@suse.com (Michal Marek)
Date: Mon, 26 Oct 2015 21:34:54 +0100
Subject: [Cocci] [PATCH v2] Coccinelle: fix incorrect -include option
 transformation
In-Reply-To: <alpine.DEB.2.10.1509221526320.6225@hadrien>
References: <56015315.507@samsung.com>
 <1442927730-18676-1-git-send-email-a.hajda@samsung.com>
 <alpine.DEB.2.10.1509221526320.6225@hadrien>
Message-ID: <562E8E6E.6060800@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 22.9.2015 v 15:27 Julia Lawall napsal(a):
> On Tue, 22 Sep 2015, Andrzej Hajda wrote:
> 
>> kbuild/gcc uses -include option to include files and -I to provide paths for
>> #include <> directive. In case of spatch latter option should be prefixed with

That hash sign in the comment was not nice :).


>> two -.
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr

Applied to kbuild.git#misc.

Michal
