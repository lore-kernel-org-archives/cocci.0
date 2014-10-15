From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 15 Oct 2014 16:05:00 +1030
Subject: [Cocci] [PATCH v2 2/7] module: add extra argument for
	parse_params() callback
In-Reply-To: <1412372683-2003-3-git-send-email-mcgrof@do-not-panic.com>
References: <1412372683-2003-1-git-send-email-mcgrof@do-not-panic.com>
 <1412372683-2003-3-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <87egu9c2uz.fsf@rustcorp.com.au>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This adds an extra argument onto parse_params() to be used
> as a way to make the unused callback a bit more useful and
> generic by allowing the caller to pass on a data structure
> of its choice. An example use case is to allow us to easily
> make module parameters for every module which we will do
> next.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Cheers,
Rusty.
