From: keescook@chromium.org (Kees Cook)
Date: Thu, 15 Mar 2018 21:21:15 -0700
Subject: [Cocci] [PATCH][RFC] kernel.h: provide array iterator
In-Reply-To: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
References: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
Message-ID: <CAGXu5jJETok21C7Au=+hh+1jMwTOqULXpL1QF5S2b_i-CoeoQw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Mar 15, 2018 at 3:00 AM, Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
> Simplify array iteration with a helper to iterate each entry in an array.
> Utilise the existing ARRAY_SIZE macro to identify the length of the array
> and pointer arithmetic to process each item as a for loop.
>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  include/linux/kernel.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> The use of static arrays to store data is a common use case throughout the
> kernel. Along with that is the obvious need to iterate that data.
>
> In fact there are just shy of 5000 instances of iterating a static array:
>         git grep "for .*ARRAY_SIZE" | wc -l
>         4943

I suspect the main question is "Does this macro make the code easier to read?"

I think it does, and we have other kinds of iterators like this in the
kernel already. Would it be worth building a Coccinelle script to do
the 5000 replacements?

-Kees

>
> When working on the UVC driver - I found that I needed to split one such
> iteration into two parts, and at the same time felt that this could be
> refactored to be cleaner / easier to read.
>
> I do however worry that this simple short patch might not be desired or could
> also be heavily bikeshedded due to it's potential wide spread use (though
> perhaps that would be a good thing to have more users) ...  but here it is,
> along with an example usage below which is part of a separate series.
>
> The aim is to simplify iteration on static arrays, in the same way that we have
> iterators for lists. The use of the ARRAY_SIZE macro, provides all the
> protections given by "__must_be_array(arr)" to this macro too.
>
> Regards
>
> Kieran
>
> =============================================================================
> Example Usage from a pending UVC development:
>
> +#define for_each_uvc_urb(uvc_urb, uvc_streaming) \
> +       for_each_array_element(uvc_urb, uvc_streaming->uvc_urb)
>
>  /*
>   * Uninitialize isochronous/bulk URBs and free transfer buffers.
>   */
>  static void uvc_uninit_video(struct uvc_streaming *stream, int free_buffers)
>  {
> -       struct urb *urb;
> -       unsigned int i;
> +       struct uvc_urb *uvc_urb;
>
>         uvc_video_stats_stop(stream);
>
> -       for (i = 0; i < UVC_URBS; ++i) {
> -               struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
> +       for_each_uvc_urb(uvc_urb, stream)
> +               usb_kill_urb(uvc_urb->urb);
>
> -               urb = uvc_urb->urb;
> -               if (urb == NULL)
> -                       continue;
> +       flush_workqueue(stream->async_wq);
>
> -               usb_kill_urb(urb);
> -               usb_free_urb(urb);
> +       for_each_uvc_urb(uvc_urb, stream) {
> +               usb_free_urb(uvc_urb->urb);
>                 uvc_urb->urb = NULL;
>         }
>
>         if (free_buffers)
>                 uvc_free_urb_buffers(stream);
>  }
> =============================================================================
>
>
>
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index ce51455e2adf..95d7dae248b7 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -70,6 +70,16 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>
> +/**
> + * for_each_array_element - Iterate all items in an array
> + * @elem: pointer of array type for iteration cursor
> + * @array: array to be iterated
> + */
> +#define for_each_array_element(elem, array) \
> +       for (elem = &(array)[0]; \
> +            elem < &(array)[ARRAY_SIZE(array)]; \
> +            ++elem)
> +
>  #define u64_to_user_ptr(x) (           \
>  {                                      \
>         typecheck(u64, x);              \
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
