import os
import flet as ft

from src.views.login import render_login


def main(page: ft.Page):
    render_login(page)


if __name__ == "__main__":
    port = int(os.getenv("PORT", 8550))
    ft.app(
        target=main,
        view=ft.WEB_BROWSER,
        host="0.0.0.0",
        port=port
    )