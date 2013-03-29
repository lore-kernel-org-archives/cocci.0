From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri, 29 Mar 2013 00:29:44 -0700
Subject: [Cocci] [PATCH] compat/compat-drivers/linux-next: fb
	skip_vt_switch
In-Reply-To: <alpine.DEB.2.02.1303290720350.2023@localhost6.localdomain6>
References: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com>
 <20130328083943.01e61b4b@jbarnes-desktop>
 <alpine.DEB.2.02.1303281718490.1928@hadrien>
 <CAB=NE6WbNwPqEPYsASAPaECe4qbAWdd4=eJ402ib+CzZbT69=g@mail.gmail.com>
 <alpine.DEB.2.02.1303281909570.1928@hadrien>
 <CAB=NE6VPRu8DvneVdwd=pXF0ngi5OifNTpZtX3pLi50i116_OA@mail.gmail.com>
 <alpine.DEB.2.02.1303282328200.2022@localhost6.localdomain6>
 <CAB=NE6WX5Dv9p2jrNwe9GxfH=EUm596uvSspsLQ5-Uuonc6Fqg@mail.gmail.com>
 <alpine.DEB.2.02.1303290720350.2023@localhost6.localdomain6>
Message-ID: <CAB=NE6U2-4uc90p5Os1kUp6QWChMcjarCMR7af0g=XUbGEXjGg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Mar 28, 2013 at 11:21 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> > I looked in today's linux-next, and there seems to be only one
>> > initialization of this field, to true, and one test of this field.  So
>> > perhaps the case for setting the field to false just isn't needed.
>>
>> Oh sorry now I get what you mean! I thought about this -- and yes I
>> decided to not add a bool false setting for the structure field given
>> that the assumption is this would not be something dynamic, and data
>> structure would be kzalloc()'d so by default they are 0.
>
> What do you do about the test, though?

Return the value.

  Luis
