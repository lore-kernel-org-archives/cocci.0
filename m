Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51B6C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/la20TO6HZbUeDgLwuWOSG8Nm8IoEXvN2+2uncV78s0=;
  b=KyTyQpTKaP9ddw6OLiMEuM1CL1z8F/2hDwQQmPqf0LhosL7MR6//quQ9
   TcX3vm+a9MxYNz5ssUUQzoKnwDEpznFH6bNkVlVvOT3I3llBu41P8afj+
   PRjH2vO5CeTQY8Kq3/xmqmwzX52lqKJns8b0DivFQYYDp/twEoSjwp05T
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207469098"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:42:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4075BE0D1E; Mon, 10 Feb 2025 12:42:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 46A58E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 12:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=/la20TO6HZbUeDgLwuWOSG8Nm8IoEXvN2+2uncV78s0=;
  b=nBWWqXcVYvprncnRUbi/4ZJB6JEDG4OaroSvk9rpaQGB8giC+YgpU6yY
   3dOh7FgG4YeykDlksX8qmu5fD+ceLgj64eUirj/E5KJD+DdDPNopsufWu
   qxLoQALtDIao6rgWKcj3xjJpZLPpD97F7OipJhuo0xwHMAaJ7Tbg45dso
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207469087"
X-MGA-submission: =?us-ascii?q?MDG5iuo0GghPh+2eAVe0PRkP7XaUnLFaqwn2ia?=
 =?us-ascii?q?DvBJX7GU68rkhgFMwYnnOvHC2Q9zfbSzSxA2X7hq4GqyO84amfiHK1yM?=
 =?us-ascii?q?xd2pxDnkxWpRTZycXX1avv5KHH6/SxdAG+7pSMVaO5Tp2EhJxCAQ2aJ7?=
 =?us-ascii?q?l9SuNFB49ZfMmLOY7PfJI99w=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 12:42:24 +0100
Date: Mon, 10 Feb 2025 12:42:24 +0100 (CET)
From: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Message-ID: <1932675609.8662032.1739187744210.JavaMail.zimbra@inria.fr>
In-Reply-To: <6a8d84cc-8bff-d68d-5d7b-fd567627149@inria.fr>
References: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr> <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr> <1948830352.8646779.1739186619092.JavaMail.zimbra@inria.fr> <6a8d84cc-8bff-d68d-5d7b-fd567627149@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.254.23.3]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - GC131 (Linux)/10.1.5_GA_4734)
Thread-Topic: Creating function definitions from function pointers in a struct with coccinelle
Thread-Index: s/AT0rJ3gYPkKaIZ4n3a92hAcT2bxw==
Subject: Re: [cocci] Creating function definitions from function pointers in
 a struct with coccinelle
Reply-To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2391
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1932675609.8662032.1739187744210.JavaMail.zimbra%40inria.fr>

Thanks a lot Julia. 

It works now.


Caleb

----- Original Message -----
> From: "Julia Lawall" <julia.lawall@inria.fr>
> To: "Fonyuy-Asheri Caleb" <fonyuy-asheri.caleb@inria.fr>
> Cc: "Julia Lawall" <julia.lawall@inria.fr>, "cocci" <cocci@inria.fr>
> Sent: Monday, February 10, 2025 12:32:15 PM
> Subject: Re: [cocci] Creating function definitions from function pointers in a struct with coccinelle

> On Mon, 10 Feb 2025, Fonyuy-Asheri Caleb wrote:
> 
>> Thank you for your prompt response
>>
>> > I'm not really sure what you are trying to do here.  Maybe if you could
>> > give an example of source code an the results you want to achieve that
>> > would be more understandable.
>> >
>>
>> I have structures defined as such in the code base but this is a problem for
>> the work I want to do.
>>
>> struct save_ops {
>>     void (*start_copy)(void *data, const char *filename);
>>     void *(*copy_finished)(const char *filename);
>>     void (*check_copied)(void *data);
>> };
>>
>> The aim of my patch is to define the following functions from the above struct
>>
>>
>> void hvm_start_copy(void *data, const char *filename);
>> void *hvm_copy_finished(const char *filename);
>> void hvm_check_copied(void *data);
>>
>> void pv_start_copy(void *data, const char *filename);
>> void *pv_copy_finished(const char *filename);
>> void pv_check_copied(void *data);
>>
>> The python m_rule I have permits me to match the list of function pointers
>> and the python script permits me to rename the pointers to the function names
>> as I have them here. Having at least the pv functions will be good for me.
>>
>> The issue now is to be able to write these to the resulting patch.
> 
> OK, maybe:
> 
> @@
> identifier I, fn;
> parameter list ps;
> fresh identifier fnhvm = "hvm_" ## fn;
> fresh identifier fnpv = "pv_" ## fn;
> @@
> 
> struct I {
>  ...
>  T (*fn)(ps);
>  ...
> };
> ++ void fnhvm(ps);
> ++ void fnpv(ps);
> 
> If that doesn't work, maybe have one rule to add the hvm functions and
> another to add the pv functions.  That would have the side benefit that
> the hvm functions would come out together and the pv functions would come
> out together.  Both groups would be attached right after the struct
> declaration, so you would want to do the pv functions first and then the
> hvm functions.
> 
> julia
