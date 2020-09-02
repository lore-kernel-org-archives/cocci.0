Return-Path: <SRS0=bt/u=CL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08433C433E6
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2020 06:41:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E682075D
	for <cocci@archiver.kernel.org>; Wed,  2 Sep 2020 06:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="peSTtPxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E682075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0826eia3010764;
	Wed, 2 Sep 2020 08:40:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF277742E;
	Wed,  2 Sep 2020 08:40:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 19C703F6C
 for <cocci@systeme.lip6.fr>; Wed,  2 Sep 2020 08:22:24 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0826MNAf005372
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 2 Sep 2020 08:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1599027741;
 bh=eFG/evPXFNnStEjj17sv7AN58cd8EKPOieW7WUQsu1E=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=peSTtPxUwj9xg4G5BZXFN+d9cIMNn7zHQXQwv5nZR6EIvOm637mJ3942g3oEUqo+4
 Mm1HRWcDrHD+THVC2SmIYQOUqDvVPX5kcBKKE7IaHQQWk0L9KA3Q8yFicGrEnwGw3B
 IZ55FQCu2OHbGP+evltApmiXOjpNDd3Z1V1KZbxA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.24.57]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiCbT-1kz0v81NMB-00nQFc; Wed, 02
 Sep 2020 08:22:21 +0200
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5d945ad3-711b-e563-5f30-11bfe97e8072@web.de>
Date: Wed, 2 Sep 2020 08:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:sxjXB4dkpabKJu+rh9+yjayX4QWiET7DzBY1RKzyE5N87s1/m36
 Us2EOe76qLniHc+jervfgpnr6noqy8NF1eZFFuHfWB9MOtjuHI+l/rTnaOycK/26DB0nwRQ
 nYHd1NVBi98GISyNGaPq8221pbanLNFoVs14ZOQh7I1EHh0Yc50wpYTmHRCvrHXP10brhyv
 14Ino5NMeZv9HrQBMlKpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GIJkP1HUUoc=:cLMpBUUN+aA/AvsxJLySuE
 rBfc/G13UuwbFlftT/iqigjUJ/zOrLpFl8DjNJMTbRKJNM1yyisXxdNVAg1NvIBKKlJJDhw1/
 R0cm+28OUnyzb9Wx0h/e5Vj/WkjPQG4TtvDYLNHFcVwdKDHER7ng2zauoNi2/gt9M/Oe/ltTK
 25fzlE2NhnjQ1HStA1KPYmzoCjsLwwSfRliEOeOpdKJ1y6cyclYX6okCImTCRCyFhQ60E4fJH
 yAVsqwOEqaf7YkJ1ngvpPNM9D+Gu3ZiDAxBncUFTuLVMXtyLQ8kO+S173LBFfhw0gLn1uasNv
 XEAC3Wyko9pV4YokOiH3oFs2tVbcy8eeOxumiUHjniqXLNm9x6XhC54v/4/MhVTGeJvAD+1hn
 ge8pz2JWW08LL+EyhibglB0lbExUC6JQfQZfp2/ZpV2snd3tDxxaf+BtGVLjrr6XNWVZgk53/
 Ux2smKyxP9Y+5cLpsr7Xq6J5ghezYZ5KwY50vPGHMCUS1W2fc0PeZcAv1HHEm/AD+h5ja0IVu
 0AQi79ijWQaNv4hG+T+Q0CsUyo4oH+miuiqEBYOJOArQsGayE/7H/Tb311ZbFVqI8SL2QTYy8
 qfys3bG/osmNlWJYyWH3O3YKZj9oOEyA2+TgP3R+4ge9Tk5/ql/w/dHRteUg/P1PJOgmoxhJK
 KkHjXRTsn5kOr9s03i1PhtwFiDGir33APofAjBtDqqVlBKAA5WgEZ2clSH7BiSz93cmjdbMZU
 Q9UGhsp+Maf6NXYyzceS1udJ+X51+/+kF9vSeGrQlSOCld4MmvnA/A2aQENhCjMcELHc6huEa
 VRejZVwWHB1qw7mXfryL+ASCwdJXK2wuBW6yycHcSUnozEhLgyhwEzDXfAiWq6wOKkZMjV/22
 Uvf+6gg4dahquNC4TVot31SKGlBu1X1rV0AfKwN60jRA9CmDSkny7PeQkkLnaUvrf7L/30hOu
 pn3igKYdjeMOJp/RCrwgxh6v1+AtxIzAkF8b4DA8SARr2x8/yKc84NxG6rTH745pH5dyTIsm8
 OnFgj55DDnYeRzqdpvromcuRXqm2Hf+5fowJCWI9W37UXZ41TZDGb+82UofvsMWP5C90UmSZw
 9FScbIyxgxc6fwQPPIonjbwOMuJY6oYMpghjEfP0JC9LnKrNMhzVXtigUZZhuBbiqfo9l1eul
 0lkF4eCRqxfz/AqmdPhDzYu9blbTsGjC+gkNixX744qFMiqM1Db459ql6CP2KefKr9AhthcEQ
 /9hfpfkfvCLulpQcPMl0z2RLm9NwrcNOO8UJ+qA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 02 Sep 2020 08:40:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 02 Sep 2020 08:22:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Wed, 02 Sep 2020 08:40:42 +0200
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: ifnullfree: add vfree(),
	kvfree*() functions
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

> Extend the list of free functions with kvfree(), kvfree_sensitive(),
> vfree().

How do you think about further software extensions for this source code search pattern?

Another example for a corresponding advanced data processing approach:
https://build.opensuse.org/project/show/home:elfring:semantic_patching:Deletion_of_checks_before_specific_function_calls

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
