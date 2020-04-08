Return-Path: <SRS0=tv+X=5Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5555DC2D0EA
	for <cocci@archiver.kernel.org>; Thu,  9 Apr 2020 06:52:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C296E206F7
	for <cocci@archiver.kernel.org>; Thu,  9 Apr 2020 06:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Jt4UEb08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C296E206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0396pXls007878;
	Thu, 9 Apr 2020 08:51:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DBF3A782B;
	Thu,  9 Apr 2020 08:51:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3FF1577F9
 for <cocci@systeme.lip6.fr>; Thu,  9 Apr 2020 00:27:17 +0200 (CEST)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:243])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 038MRGEf028958
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 9 Apr 2020 00:27:16 +0200 (CEST)
Received: by mail-lj1-x243.google.com with SMTP id 142so4865856ljj.7
 for <cocci@systeme.lip6.fr>; Wed, 08 Apr 2020 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0IxhJthYzoFGzHPRNJEuwsAmGxzG5+XUgsaLtHukDmo=;
 b=Jt4UEb08cWeiS20+2wlm3OhfNdeq68MS15GaeQ7aBN6rERE2M6pKSwmxcdCu2CIxAd
 Nsb/9hmyaCIptWmS7Q8wVxdaWRIKVTd3NnESPyzok7t6R0iYUhjZnD/+WFPEd7D+EQkp
 k7561fyi3XD5Bf5R0FqG5Jii6fTBO5eH68o9bwYiHvbjhTm4xS1G0WNSNXlFWubhWpxv
 yNdaUvOI3XtWwuvJfoJhwPSEyvrEpRLxLIBADqcFX/2dwr4Gvb0SNJ8yI0rNUkdo+fNL
 cRfDeJB6G2RtRBTurl4ijWTPuSAN501p4bPgj2e8IkIxRrZZAKQrmD7JI0mRQxK1OeLS
 LYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0IxhJthYzoFGzHPRNJEuwsAmGxzG5+XUgsaLtHukDmo=;
 b=JCly+xf7A5OSGalycBMaHWIKoLeK8dlBCVtAcq1gY4K6+A5Nfn8FXC75A5Jgpd9NU3
 Ssxzglju0zFE6KDShWCexK8p/9/86xL0hJ+/lGXu81OChx7jCGr0XjJUugGcEejZvTw8
 ZD7nOIfIihszh0xALWP2XOjtSl7+yickgt0Olau+mw3PdOFvsHw5YscjMPWrHg3/BPgX
 SA+3HqEk9cCvDkKRbCW4usJvf8e+jvo2IrK/M/rDZ1NHqht+beIU3cBzn88CC+KwEafy
 w7tYtSBPFfb3KsLtwABsQkWcEoq91rDjQ/jWW+Qc8d4Aa+1IxkLAP8VjIfaVL6BGzgFO
 ey/Q==
X-Gm-Message-State: AGi0Pub8Nygo0Avu7ryQQp7BGXTLIoK7WDXOJuqy+aCxfVMyHC9cupI1
 xnlZ34UwxlZQxy2elGeh0ChIlHNqd3WFKOh8LofDRA==
X-Google-Smtp-Source: APiQypKw3pUMTJPpu9PX8DKDTel9965lGRN2jMKefg+mFHDV23V0n9xzRSOYGpKDCRGHdJbIYIRbz0DZDEi2uCjq5Uc=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr5980354ljg.215.1586384835570; 
 Wed, 08 Apr 2020 15:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <fff664e9-06c9-d2fb-738f-e8e591e09569@linux.com>
In-Reply-To: <fff664e9-06c9-d2fb-738f-e8e591e09569@linux.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 9 Apr 2020 00:26:49 +0200
Message-ID: <CAG48ez09gn1Abv-EwwW5Rgjqo2CQsbq6tjDeTfpr_FnJC7f5zA@mail.gmail.com>
To: Alexander Popov <alex.popov@linux.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 09 Apr 2020 08:51:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 09 Apr 2020 00:27:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 09 Apr 2020 08:51:30 +0200
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
        "kernel-hardening@lists.openwall.com"
 <kernel-hardening@lists.openwall.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, cocci@systeme.lip6.fr,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [Cocci] Coccinelle rule for CVE-2019-18683
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Thu, Apr 9, 2020 at 12:01 AM Alexander Popov <alex.popov@linux.com> wrote:
> CVE-2019-18683 refers to three similar vulnerabilities caused by the same
> incorrect approach to locking that is used in vivid_stop_generating_vid_cap(),
> vivid_stop_generating_vid_out(), and sdr_cap_stop_streaming().
>
> For fixes please see the commit 6dcd5d7a7a29c1e4 (media: vivid: Fix wrong
> locking that causes race conditions on streaming stop).
>
> These three functions are called during streaming stopping with vivid_dev.mutex
> locked. And they all do the same mistake while stopping their kthreads, which
> need to lock this mutex as well. See the example from
> vivid_stop_generating_vid_cap():
>     /* shutdown control thread */
>     vivid_grab_controls(dev, false);
>     mutex_unlock(&dev->mutex);
>     kthread_stop(dev->kthread_vid_cap);
>     dev->kthread_vid_cap = NULL;
>     mutex_lock(&dev->mutex);
>
> But when this mutex is unlocked, another vb2_fop_read() can lock it instead of
> the kthread and manipulate the buffer queue. That causes use-after-free.
>
> I created a Coccinelle rule that detects mutex_unlock+kthread_stop+mutex_lock
> within one function.
[...]
> mutex_unlock@unlock_p(E)
> ...
> kthread_stop@stop_p(...)
> ...
> mutex_lock@lock_p(E)

Is the kthread_stop() really special here? It seems to me like it's
pretty much just a normal instance of the "temporarily dropping a
lock" pattern - which does tend to go wrong quite often, but can also
be correct.

I think it would be interesting though to have a list of places that
drop and then re-acquire a mutex/spinlock/... that was not originally
acquired in the same block of code (but was instead originally
acquired in an outer block, or by a parent function, or something like
that). So things like this:

void X(...) {
  mutex_lock(A);
  for (...) {
    ...
    mutex_unlock(A);
    ...
    mutex_lock(A);
    ...
  }
  mutex_unlock(A);
}

or like this:

void X(...) {
  ... [no mutex operations on A]
  mutex_unlock(A);
  ...
  mutex_lock(A);
  ...
}


But of course, there are places where this kind of behavior is
correct; so such a script wouldn't just return report code, just code
that could use a bit more scrutiny than normal. For example, in
madvise_remove(), the mmap_sem is dropped and then re-acquired, which
is fine because the caller deals with that possibility properly:

static long madvise_remove(struct vm_area_struct *vma,
                                struct vm_area_struct **prev,
                                unsigned long start, unsigned long end)
{
        loff_t offset;
        int error;
        struct file *f;

        *prev = NULL;   /* tell sys_madvise we drop mmap_sem */

        if (vma->vm_flags & VM_LOCKED)
                return -EINVAL;

        f = vma->vm_file;

        if (!f || !f->f_mapping || !f->f_mapping->host) {
                        return -EINVAL;
        }

        if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
                return -EACCES;

        offset = (loff_t)(start - vma->vm_start)
                        + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);

        /*
         * Filesystem's fallocate may need to take i_mutex.  We need to
         * explicitly grab a reference because the vma (and hence the
         * vma's reference to the file) can go away as soon as we drop
         * mmap_sem.
         */
        get_file(f);
        if (userfaultfd_remove(vma, start, end)) {
                /* mmap_sem was not released by userfaultfd_remove() */
                up_read(&current->mm->mmap_sem);
        }
        error = vfs_fallocate(f,
                                FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                                offset, end - start);
        fput(f);
        down_read(&current->mm->mmap_sem);
        return error;
}
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
