From: jack@suse.cz (Jan Kara)
Date: Mon, 1 Dec 2014 20:26:44 +0100
Subject: [Cocci] Unmatching rule
In-Reply-To: <20141201192133.GA5324@quack.suse.cz>
References: <20141201192133.GA5324@quack.suse.cz>
Message-ID: <20141201192644.GB5324@quack.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon 01-12-14 20:21:33, Jan Kara wrote:
>   Hello,
> 
>   I was doing some conversion using coccinelle using the attached script
> and I'm wondering why the rule unreg2 doesn't match anywhere in linux
> kernel in drivers/media/dvb-core/dvbdev.c. Can someone explain to me
> what am I doing wrong? Thanks!
  Ah, I figured it out a moment after I sent this email. The prerequisite
rule wasn't matching and I missed that when looking at the generated diff.

								Honza

> -- 
> Jan Kara <jack@suse.cz>
> SUSE Labs, CR

> @decl@
> identifier x;
> @@
> -static struct cdev x;
> 
> @initadd@
> identifier decl.x;
> expression fops;
> identifier ret;
> expression d;
> expression count;
> statement stmt;
> @@
> -	cdev_init(&x, fops);
> (
> -	ret = cdev_add(&x, d, count);
> -	if (<+...ret...+>) stmt
> |
> -	if (<+...cdev_add(&x, d, count)...+>) stmt
> )
> 
> @creationdyn@
> identifier d;
> identifier ret;
> identifier major;
> expression initadd.fops;
> expression name;
> expression initadd.count;
> expression first_minor;
> @@
> -	dev_t d;
> ...
> -	ret = alloc_chrdev_region(&d, first_minor, count, name);
> +	ret = __register_chrdev(0, first_minor, count, name, fops);
> ...
> -	major = MAJOR(d);
> +	major = ret;
> 
> @creationstat@
> identifier d;
> identifier ret;
> expression major;
> expression initadd.fops;
> expression name;
> expression initadd.count;
> expression first_minor;
> statement stmt;
> @@
> -	dev_t d = MKDEV(major, first_minor);
> ...
> (
> -	ret = register_chrdev_region(d, count, name);
> +	ret = __register_chrdev(major, first_minor, count, name, fops);
> |
> -	if (<+...ret = register_chrdev_region(d, count, name)...+>) stmt
> +	ret = __register_chrdev(major, first_minor, count, name, fops);
> +	if (ret) stmt
> )
> 
> @deletion@
> identifier decl.x;
> @@
> -	cdev_del(&x);
> 
> @unreg@
> identifier d;
> expression count;
> expression major, minor;
> expression creationstat.name;
> @@
> -	dev_t d = MKDEV(major, minor);
> 	...
> -	unregister_chrdev_region(d, count);
> +	__unregister_chrdev(major, minor, count, name);
> 
> @unreg2@
> expression d;
> expression count;
> expression creationstat.major, creationstat.first_minor;
> expression creationstat.name;
> @@
> -	unregister_chrdev_region(d, count);
> +	__unregister_chrdev(major, first_minor, count, name);

-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
