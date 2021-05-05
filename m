Return-Path: <SRS0=OUc2=KA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF679C433B4
	for <cocci@archiver.kernel.org>; Wed,  5 May 2021 08:58:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0432861157
	for <cocci@archiver.kernel.org>; Wed,  5 May 2021 08:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0432861157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1458wibF008749;
	Wed, 5 May 2021 10:58:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 06C837801;
	Wed,  5 May 2021 10:58:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 041033783
 for <cocci@systeme.lip6.fr>; Wed,  5 May 2021 10:44:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 1458igeW024292
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 5 May 2021 10:44:43 +0200 (CEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 886BE611AE;
 Wed,  5 May 2021 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620204281;
 bh=z440MLLOO4SJA+ueCYGzYqDld3Rl/TPdNEGP6iE8Utw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c8jcZziBFNTcFefF+TkDwjbao3SKwIkgiLelPlbex6qxJ0e7EX6Tct8B8NV5oIWRg
 bD5Ji/KrDk4q3AiWeSVTGYnKCoUlj/0VKXrerhcb2iPtcMELM2kCK3y/M8tBPsECXN
 QZP4Px8WqxrfVnIcm6m877//NZCw0r2XSTAzp8GuZB21B/lV87X1qOqonU4gaGEXUF
 2eaScP6o+Jfv9BuqiCU/WsxueRNZOmpvbiT6V7L3u2iR9yCpRtfU8LsTwguT+wAkvk
 qIyb0WIOV0JlsGDzAmqWvVimnpVjf0qLYPAEc+q/mO2Q8O2O1i/Sf8GRQDF9fyxmSg
 p7TgJigcRnVVw==
Date: Wed, 5 May 2021 10:44:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Message-ID: <20210505104434.7d7838f0@coco.lan>
In-Reply-To: <20210429174343.2509714-1-Julia.Lawall@inria.fr>
References: <20210429174343.2509714-1-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 May 2021 10:58:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 May 2021 10:44:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 05 May 2021 10:58:42 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel-janitors@vger.kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>, cocci@systeme.lip6.fr,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Cocci] [PATCH v5] coccinelle: api: semantic patch to use
 pm_runtime_resume_and_get
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

Hi Julia,

Em Thu, 29 Apr 2021 19:43:43 +0200
Julia Lawall <Julia.Lawall@inria.fr> escreveu:

> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.  Specifically, the
> change is only done when pm_runtime_get_sync is followed immediately
> by an if and when the branch of the if is immediately a call to
> pm_runtime_put_noidle (like in the definition of
> pm_runtime_resume_and_get) or something that is likely a print
> statement followed by a pm_runtime_put_noidle call.  The patch
> case appears somewhat more complicated, because it also deals with the
> cases where {}s need to be removed.
> 
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

First of all, thanks for doing that! It sounds a lot better to have
a script doing the check than newbies trying to address it manually,
as there are several aspects to be considered on such replacement.

> 
> ---
> v5: print a message with the new function name, as suggested by Markus Elfring
> v4: s/pm_runtime_resume_and_get/pm_runtime_put_noidle/ as noted by John Hovold
> v3: add the people who signed off on commit dd8088d5a896, expand the log message
> v2: better keyword
> 
>  scripts/coccinelle/api/pm_runtime_resume_and_get.cocci |  153 +++++++++++++++++
>  1 file changed, 153 insertions(+)
> 
> diff --git a/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> new file mode 100644
> index 000000000000..3387cb606f9b
> --- /dev/null
> +++ b/scripts/coccinelle/api/pm_runtime_resume_and_get.cocci
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use pm_runtime_resume_and_get.
> +/// pm_runtime_get_sync keeps a reference count on failure,
> +/// which can lead to leaks.  pm_runtime_resume_and_get
> +/// drops the reference count in the failure case.
> +/// This rule addresses the cases where the reference count
> +/// is unlikely to be needed in the failure case.
> +///
> +// Confidence: High

Long story short, I got a corner case where the script is doing
the wrong thing.

---

A detailed explanation follows:

As you know, I'm doing some manual work to address issues related
to pm_runtime_get() on media.

There, I found a corner case: There is a functional difference
between:

	ret = pm_runtime_get_sync(&client->dev);
        if (ret < 0) {
                pm_runtime_put_noidle(&client->dev);
		return ret;
	}

and:
	ret = pm_runtime_resume_and_get(&client->dev);
        if (ret < 0)
		return ret;

On success, pm_runtime_get_sync() can return either 0 or 1.
When 1 is returned, it means that the driver was already resumed.

pm_runtime_resume_and_get(), on the other hand, don't have the same
behavior. On success, it always return zero.

IMO, this is actually a good thing, as it helps to address a common
mistake:

	ret = pm_runtime_get_sync(&client->dev);
	/*
	 * or, even worse: 
	 * ret = some_function_that_calls_pm_runtime_get_sync(); 
	 */

        if (ret) {
                pm_runtime_put_noidle(&client->dev);
		return ret;
	}

FYI, Dan pointed one media driver to me those days with the above
issue at the imx334 driver, which I'm fixing on my patch series. 

-

Anyway, after revisiting my patches, I found several cases that were 
doing things like:

	int ret;

	ret = pm_runtime_get_sync(dev);
	pm_runtime_put_noidle(dev);		/* Or without it, on drivers with unbalanced get/put */

	return ret > 0 ? 0 : ret;

Which can be replaced by just:

	return pm_runtime_resume_and_get(&ctx->gsc_dev->pdev->dev);

Yet, I found a single corner case on media where a driver is actually 
using the positive return: the ccs-core camera sensor driver.

There, the driver checks the past state of RPM. If the
device was indeed suspended, the driver restores the hardware
controls (on V4L2, a control is something like brightness, 
contrast, etc) to the last used value set.

This is the right thing to be done there, as setting values
to such hardware can be a slow operation, as it is done via I2C.

So, this particular driver checks if the RPM returned 0 or 1,
in order to check the previous RPM state before get.

In this particular case, replacing:
	pm_runtime_get_sync()
with
	pm_runtime_resume_and_get()

Will make part of the code unreachable. 

While it won't break this specific driver, It could have
cause troubles if the logic there were different.

In any case, I tested the coccinelle script, and it produces
this change:

 static int ccs_pm_get_init(struct ccs_sensor *sensor)
 {
        struct i2c_client *client = v4l2_get_subdevdata(&sensor->src->sd);
        int rval;
 
-       rval = pm_runtime_get_sync(&client->dev);
-       if (rval < 0) {
-               pm_runtime_put_noidle(&client->dev);
+       rval = pm_runtime_resume_and_get(&client->dev);
+       if (rval < 0)
 
                return rval;
-       } else if (!rval) {
+       else if (!rval) {
                rval = v4l2_ctrl_handler_setup(&sensor->pixel_array->
                                               ctrl_handler);
                if (rval)
                        return rval;
 
                return v4l2_ctrl_handler_setup(&sensor->src->ctrl_handler);
        }
 
        return 0;

which will make v4l2_ctrl_handler_setup() to always being called,
even if the device was already resumed.

Thanks,
Mauro
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
