From: mmarek@suse.com (Michal Marek)
Date: Thu, 28 Jul 2016 13:23:07 +0200
Subject: [Cocci] [PATCH v2] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <20160728082944.GA25524@amitoj-Inspiron-3542>
References: <20160728082944.GA25524@amitoj-Inspiron-3542>
Message-ID: <5799EB1B.3030203@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2016-07-28 10:29, Amitoj Kaur Chawla wrote:
> This script finds instances of allocate and memset which can be
> replaced with a direct call to zalloc equivalent of a function.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
> Changes in v2:
>         -Modified commit message and subject

There is still memcpy in the comment here:


> +/// Prefer zalloc functions instead of using allocate and memcpy.

:)

Michal
