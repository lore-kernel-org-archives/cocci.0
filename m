Return-Path: <SRS0=evXM=PL=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3DEC433EF
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 19:18:30 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C17660F36
	for <cocci@archiver.kernel.org>; Sat, 23 Oct 2021 19:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C17660F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,176,1631570400"; 
   d="scan'208";a="135493"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Oct 2021 21:18:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CFD62E001A; Sat, 23 Oct 2021 21:18:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 62F78E0015
	for <cocci@sympa.inria.fr>; Sat, 23 Oct 2021 21:18:26 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=keescook@chromium.org; spf=Pass smtp.mailfrom=keescook@chromium.org; spf=None smtp.helo=postmaster@mail-pj1-f52.google.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AoaM/QxOiDVlk04ChRVQl6nbcDRdPi9zP1u491JM?=
 =?us-ascii?q?rhvp0f7i5+Ny6ZQqDv60r1gSRFtyBtrptsKn/i+jYQ2sO4JKM4jgpUadncFs7s?=
 =?us-ascii?q?/gQhBEqG8WfCEf2f7bAZi0+G9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQp?=
 =?us-ascii?q?yO+/5BpPeg9642uys55HfeRtEiTShbb99MRm6swXcvdQKjIV/Lao81gHHqWZSd?=
 =?us-ascii?q?eRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9LmA6/9brugX?=
 =?us-ascii?q?ZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/9KpgVgPmh?=
 =?us-ascii?q?zkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2hcUcZLTyFPDIO?=
 =?us-ascii?q?yYZUSAeQCM+ZXoJXyqEYMohalGQmgGPnixiNUinPqw6E31fkqHwHc3AwnGtIDq?=
 =?us-ascii?q?HHao8vrO6cJTOu40q7IzTLAb/hL3jr965bHfQ46of6QWrJwdsnRxFIzGAPFlFW?=
 =?us-ascii?q?QronlPzKI1uQIqWSb6PBgVe22hmMhtgp+rSShyN02hYnVmoIa1ErE9SNhzYg1J?=
 =?us-ascii?q?dO1TEx2bNG4HZdOuSyXNpZ7T80sTmxnuCg31KMLtIO5cSUEyZkq2QDSZvKJfoS?=
 =?us-ascii?q?V7R/uSuicLSt3iXxlfL+ygQu5/0u4yuDkSMW4zFJHojBGn9TMrHwByQHf58mdR?=
 =?us-ascii?q?vZ94EutwSuD2gTQ5+1ePEw5mqrWJ4Qgz7M/jJYfrEXOEyHwlU7rlqGZbF8k9fK?=
 =?us-ascii?q?t6+n/YrXpuJucN4hshwH7KKsum8i/Df0gMggMQmSX4Oq82b398UHjT7VKifo2k?=
 =?us-ascii?q?qbdsJ/EP8gUuqm5AwpN3oYi7RawESum3cwGkXUbKF9JYhGKgojzN13QPfz1DO2?=
 =?us-ascii?q?zjlSynDtzwvDJJLzhApHDLnjZl7fheK5w601CxwUt1tBQ+5VUCrYCIP/oRkDxt?=
 =?us-ascii?q?MbYDhg8Mwy13ubnDc9x1oQEWWKAGqOZKr/dsUeU5uIzJOmBfJMauDHhJPc55v7?=
 =?us-ascii?q?jlmQ5mF8Yfamxx5QbcnG4HvJ8I0WYe3XgmNkBEX1Z9jY5Gc73jFyLGRpaeH+2W?=
 =?us-ascii?q?+po5Cw/CYvgCY7cT4SpqL2HxiayWJNMMDNoEFeJRFTlep7McPALa2rGIcJsiTc?=
 =?us-ascii?q?DUruJQI870hSvqQq8zKBoeLmHshYEvI7ugYAmr9bYkgs/oHktV5z1O4ClSmh1m?=
 =?us-ascii?q?iYQRWZz0v0l50N6zViH3O5zhPkKTbS7AttCUh09MJ/Byqp9Ed+gAmopkf+CSEy?=
 =?us-ascii?q?hR9S7BHc2VN1jmrcz?=
IronPort-Data: =?us-ascii?q?A9a23=3ALJn/ZqoXtUwB5EQ7D9npB78AbkZeBmJ1ZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmtLDT/VaP3bMDSgf9snb4/lp0IOup7Tm9BlQVRqrykyZn8b8?=
 =?us-ascii?q?sCt6faxfh6hZXvKRiHgZBs6tJtGMoGowPjZ/xYwnz/1WlTahSQ6hf7gqobUUra?=
 =?us-ascii?q?eY3kpH1Q8E0/NtDo68wIHqt4w6TSGK1jV0T/Ci5W31G6Ng1aYAEpMg06wgE8HU?=
 =?us-ascii?q?MDJhd8tlgdWicanE7PpvyJ94Jo3fcldJpZjK2VeNrbSq+3rlNlV8o5FlirBBO9?=
 =?us-ascii?q?Jkp6jGqELarvbPAzLkngPHqb/2F5NoSs91qt9P/0ZAatVo2/RzpYhlZMX7ML2F?=
 =?us-ascii?q?F1B0q7kwIzxVzFbHixlNqpB+5fMIWK4tM2OygvBaXSEL/BGVRprYdxBkgpwKTg?=
 =?us-ascii?q?WqaZwxCo2RhuEjOm36KmqT/FlwMUlNsjieo0F0kyMZxnNVaN8B8/XGvCSo4dMh?=
 =?us-ascii?q?mJowJofTK/KPJ9BL2d7M0HpfTlkP3M7CLYflcGUnF3BchhM8QrA/PNzuXy7IBd?=
 =?us-ascii?q?Z1bHsNJ/NeIXPS5gP2EmfoW3C8iLyBRRyCTBW8hLdmlrEuwMFtXmTtEMu+LyEG?=
 =?us-ascii?q?jpChVSSwikLCkRTWwbh5/a+jUG6VpRULEl8Fu8GxUQt3BTDczU/d0TQTL24Uto?=
 =?us-ascii?q?0UNpKFOg79QTLzbDbi+pcLnZRVSZPMbTKq+dvLQHHFTa1cxfBDjx1t7iUVHfb8?=
 =?us-ascii?q?a2bxd93EUD5MkdaDRI5ocA5DxUPbW39Yt8jjjquLUJtsuDIJA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AyDhRoKz/mcxvKdekxW5yKrPwRL1zdoMgy1kn?=
 =?us-ascii?q?xilNoHNuH/Bw+/rDoB1k73DJYV8qMRlK8+yoIrWKQn/X6PdOj7UsAQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AfAACxXnRhfzTYVdFaHQEBAQEJARIBB?=
 =?us-ascii?q?QUBQIFGBwELAYN2a41KhWiCKJETixGBfAsBAwELAQFBBAEBhQACgk4CHQcBBDE?=
 =?us-ascii?q?IDgECBBUBAQUBAQECAQMDBAETAQENCxAIOCaFaA2CNSkBg2QBAQEDEigGAQEsC?=
 =?us-ascii?q?wEPCxguNAEFARwGEyKFV59LgQQ9izCBM4EBgggBAQaGBYFaCQkBCIEoAYl5gyJ?=
 =?us-ascii?q?6JxyBSUSEPz6IFIIukTGSRI8SnTeDPIE5C51mEYNHARGRc5E/lgyCP6M9AgoHB?=
 =?us-ascii?q?hAjgT8BghIzGggoCDuCaVEZD44giQaFaiEzOAIGCwEBAwmSbwEB?=
X-IPAS-Result: =?us-ascii?q?A0AfAACxXnRhfzTYVdFaHQEBAQEJARIBBQUBQIFGBwELAYN?=
 =?us-ascii?q?2a41KhWiCKJETixGBfAsBAwELAQFBBAEBhQACgk4CHQcBBDEIDgECBBUBAQUBA?=
 =?us-ascii?q?QECAQMDBAETAQENCxAIOCaFaA2CNSkBg2QBAQEDEigGAQEsCwEPCxguNAEFARw?=
 =?us-ascii?q?GEyKFV59LgQQ9izCBM4EBgggBAQaGBYFaCQkBCIEoAYl5gyJ6JxyBSUSEPz6IF?=
 =?us-ascii?q?IIukTGSRI8SnTeDPIE5C51mEYNHARGRc5E/lgyCP6M9AgoHBhAjgT8BghIzGgg?=
 =?us-ascii?q?oCDuCaVEZD44giQaFaiEzOAIGCwEBAwmSbwEB?=
X-IronPort-AV: E=Sophos;i="5.87,176,1631570400"; 
   d="scan'208";a="135491"
X-MGA-submission: =?us-ascii?q?MDHWgJN1w9IIy6Xm5fi4QapEdp+IHLw9o+FKTm?=
 =?us-ascii?q?VuScu4CaxzUmQTYenb1KFcZY+Slj/UNwUtJQfBmJjrwr6lvq+QO3VSVt?=
 =?us-ascii?q?ER3GIcjPm67NuRczP3yri0U4dsVZJF2v7fC+wrj3sPzkyNYDCsVaZAQO?=
 =?us-ascii?q?uD/208ftOjFWnB5LZGQrbYwg=3D=3D?=
Received: from mail-pj1-f52.google.com ([209.85.216.52])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2021 21:18:25 +0200
Received: by mail-pj1-f52.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so5371259pjb.5
        for <cocci@inria.fr>; Sat, 23 Oct 2021 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iusnW8LyX48emfkYiOdYVBbD1X7DC6XhQSttfD8Gqis=;
        b=g/g3MV05++LaBbUi9D6865UMJWpw+cEnId7lT6KIRMqo1avnuXfYWNiEYc8efnFxT6
         wrXeE8g4PE8yGEbR2FuGO6KI9ye0vTnvEYpulGNnXL3sIsl/0b/wpByCG2dBElGl4hQr
         DSeDpHFRDffE4CVHViz+SwOL7i4V4jY32NhpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iusnW8LyX48emfkYiOdYVBbD1X7DC6XhQSttfD8Gqis=;
        b=E7atX9DPd+q+ypE7SegiONI61nzSwOPVsCVoN9o1QoGVqYMzovs2U8r/eum5DU40kd
         sIXid4W5k7HKaMLXgBvzuw0lcGrGnptCceI1ME/QKnsoAgSIw5XweZ/r7ao5zisYGE6v
         6anGGOEwdrSywQi73ARokNEVyfEeHi5d7G5Bc/keWNnYs8jKvO4SDuWBqQsSZAlTqE6/
         Wqw0fL+goMXEfEbku31WOVTG0fMky/n9iaGd4ilTIVhxrWD5iNhoyfB2xe9mb6Sdt+3x
         /5pRfgMrzu8nfEHTnI4+uQZANy8v27PXRnj1ugrnWzPW0Ro+PohLwC9a6ZQ4tUKFB20C
         N8gQ==
X-Gm-Message-State: AOAM531GA9j+k30cByAE1WkJlhAewNaYuYKits90u2k/FoDFTow0GKx7
	CzXgh4/CHtCvjpqEteuIOxGjjAPJWjx/HA==
X-Google-Smtp-Source: ABdhPJz7cJMv3ORC3LX8UqExQ0osjmHKclF9f3qtqX7yiDSwSYdsQXHHtRqFhooHQi+ugi9LIQIgFQ==
X-Received: by 2002:a17:903:2304:b0:13f:2457:11dd with SMTP id d4-20020a170903230400b0013f245711ddmr7173973plh.57.1635016703678;
        Sat, 23 Oct 2021 12:18:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm6921309pfh.118.2021.10.23.12.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 12:18:23 -0700 (PDT)
Date: Sat, 23 Oct 2021 12:18:22 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Joe Perches <joe@perches.com>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, Kees Cook <kees@outflux.net>
Message-ID: <202110231218.45D0EDB@keescook>
References: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2110231908290.21613@hadrien>
Subject: Re: [cocci] [PATCH v2] coccinelle: update Coccinelle entry
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 31
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/202110231218.45D0EDB%40keescook>

On Sat, Oct 23, 2021 at 07:10:06PM +0200, Julia Lawall wrote:
> Update mailing list, website, and tree.  Drop Michal Marek as a
> maintainer, who has not participated in a long time.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
