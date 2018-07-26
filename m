From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 17:44:48 -0500
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <alpine.DEB.2.20.1807270034400.2489@hadrien>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
 <alpine.DEB.2.20.1807270034400.2489@hadrien>
Message-ID: <CAOZdJXWgmXbbTjOJL2osCLE_sy7kdb-_fnrPx7QnrSuZCnaQ2A@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 26, 2018 at 5:36 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> The easiest thing would be to use python.  You can look at
> demos/pythontococci.cocci for an example.  If you send a complete change
> that you would like to make, I can write an example rule.

My goal is to replace usage of a deprecated macro with a new one, but
some of the parameters has changed.

So

DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS, "NVRM: error status:
0x%x\n", status));

becomes

NV_PRINTF(LEVEL_ERROR, "failed to blacklist GPU: 0x%x\n", status);

So I think I've got everything except the removal of "NVRM: " from the
beginning of any strings where the macro has been changed.
