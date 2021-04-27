Return-Path: <SRS0=jsWv=J2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADCBC433B4
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DF961459
	for <cocci@archiver.kernel.org>; Thu, 29 Apr 2021 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DF961459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13TIDqgv003217;
	Thu, 29 Apr 2021 20:13:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F05F477FB;
	Thu, 29 Apr 2021 20:13:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E52423DD8
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 17:05:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13RF5FFY022632
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 27 Apr 2021 17:05:16 +0200 (CEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27A9761178;
 Tue, 27 Apr 2021 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619535914;
 bh=v5U4mUr4UALNU8p56i3DOzDfcVR28sMSJC2daVo3NnQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EoJDDrO0R+1JC5SwG8srBDphbX0Nm+yfxkBekisAcAHxi4UHSX9en5QgZ7Py+mNhN
 gKZ1lWlts4XawV7gBsW8aLTDctrGFqT7TOlutdulDOXD+OL53zOsm3zSrWN3mOQms4
 IqA65Dic3saBWYVwldAIaPEnZCy4v0byKfrEbKgqXKRNueAc6cltqRIJkDOr+S4jYq
 7tLCFB+ERvlPJnNNBEbgAOwhyTKXI85dpeVyND72c/plT9Y404P1FpMkw7x39KwMD0
 A6s4xWCecLb7telhCZgwFAkGXsPQD9ibmyR4hPehj55mEu3WmDiRkkFJQiH+2MD5WN
 sO3NJlRIiAo9A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
 (envelope-from <johan@kernel.org>)
 id 1lbPHE-0002y9-0q; Tue, 27 Apr 2021 17:05:28 +0200
Date: Tue, 27 Apr 2021 17:05:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Message-ID: <YIgoOH04vO3KPSBs@hovoldconsulting.com>
References: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427125834.2477467-1-Julia.Lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Apr 2021 20:13:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Apr 2021 17:05:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 29 Apr 2021 20:13:50 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Zhang Qilong <zhangqilong3@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v3] coccinelle: api: semantic patch to use
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

On Tue, Apr 27, 2021 at 02:58:34PM +0200, Julia Lawall wrote:
> pm_runtime_get_sync keeps a reference count on failure, which can lead
> to leaks.  pm_runtime_resume_and_get drops the reference count in the
> failure case.  This rule very conservatively follows the definition of
> pm_runtime_resume_and_get to address the cases where the reference
> count is unlikely to be needed in the failure case.  Specifically, the
> change is only done when pm_runtime_get_sync is followed immediately
> by an if and when the branch of the if is immediately a call to
> pm_runtime_put_noidle (like in the definition of
> pm_runtime_resume_and_get) or something that is likely a print
> statement followed by a pm_runtime_resume_and_get call.  The patch

s/pm_runtime_resume_and_get/pm_runtime_put_noidle/

> case appears somewhat more complicated, because it also deals with the
> cases where {}s need to be removed.
> 
> pm_runtime_resume_and_get was introduced in
> commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to
> deal with usage counter")
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
> v3: add the people who signed off on commit dd8088d5a896, expand the log message
> v2: better keyword

Johan
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
