From: mmarek@suse.cz (Michal Marek)
Date: Tue, 20 Nov 2012 10:58:58 +0100
Subject: [Cocci] [PATCH] Coccicheck: Improvement for online checking
 with 'make C=[12]'
In-Reply-To: <1350031730-20822-1-git-send-email-nicolas.palix@imag.fr>
References: <1350031730-20822-1-git-send-email-nicolas.palix@imag.fr>
Message-ID: <50AB5462.9030401@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Nicolas,

sorry for the delay.

On 12.10.2012 10:48, Nicolas Palix wrote:
> +    # The ignore_unknown_options flag requires Coccinelle >= 0.2.3
> +    FLAGS="-ignore_unknown_options -very_quiet"
> +    if [ "$KBUILD_EXTMOD" = "" ] ; then
> +        OPTIONS="-dir $srctree $*"

Why is -Iinclude not needed in this case?


> +    else
> +        OPTIONS="-dir $KBUILD_EXTMOD -patch $srctree -I $srctree/include -I $KBUILD_EXTMOD/include $*"
> +    fi

The main Makefile exports the $LINUXINCLUDE variable, which contains all
the needed -I options. It would be cleaner to use that instead.

Michal
