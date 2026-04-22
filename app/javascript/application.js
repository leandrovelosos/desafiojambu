// Importações padrão do Rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

// Evento correto para Rails com Turbo
document.addEventListener("turbo:load", () => {

    // 🔹 Elementos da tela
    const input = document.getElementById("search-input")
    const suggestionsBox = document.getElementById("suggestions")
    const categorySelect = document.querySelector("select[name='category']")

    // 🔒 Evita erro em páginas que não têm busca
    if (!input || !suggestionsBox || !categorySelect) return

    // 🛑 Evita duplicar listeners com Turbo
    if (input.dataset.listenerAttached === "true") return
    input.dataset.listenerAttached = "true"

    // 🔹 Controle de debounce (tempo ideal: 300ms)
    let timeout = null

    // 🔹 Controle de cancelamento de requisições anteriores
    let controller = null

    input.addEventListener("input", () => {

        clearTimeout(timeout)

        timeout = setTimeout(async () => {

            const query = input.value.trim()

            // ❌ Evita chamadas desnecessárias
            if (query.length < 2) {
                suggestionsBox.innerHTML = ""
                return
            }

            const category = categorySelect.value

            try {
                // 🔥 Cancela requisição anterior (se ainda estiver rodando)
                if (controller) controller.abort()

                controller = new AbortController()

                // feedback visual para mostrar que as sugestoes vao aparecer 
                //        suggestionsBox.innerHTML = `
                //         <div class="list-group-item text-muted">
                //          Buscando...
                //       </div>
                //     `

                const response = await fetch(
                    `/suggestions?query=${encodeURIComponent(query)}&category=${category}`,
                    { signal: controller.signal }
                )

                const data = await response.json()

                // 🔹 Limpa sugestões antigas
                suggestionsBox.innerHTML = ""

                if (data.length === 0) {
                    suggestionsBox.innerHTML = `
                      <div class="list-group-item text-muted">
                        Nenhum resultado
                      </div>
                    `
                    return
                }

                // 🔹 Cria sugestões
                data.forEach(item => {

                    const div = document.createElement("a")

                    div.className = "list-group-item list-group-item-action"
                    div.textContent = item

                    // 🔹 Ao clicar, preenche o input
                    div.addEventListener("click", () => {
                        input.value = item
                        suggestionsBox.innerHTML = ""
                    })

                    suggestionsBox.appendChild(div)
                })

            } catch (error) {
                // ❌ Ignora erro de cancelamento (normal)
                if (error.name !== "AbortError") {
                    console.error("Erro ao buscar sugestões:", error)
                }
            }

        }, 300) // ✅ valor correto (antes estava 10ms)
    })

    // 🔹 Fecha sugestões ao clicar fora
    document.addEventListener("click", (event) => {
        if (!event.target.closest("#search-input") &&
            !event.target.closest("#suggestions")) {
            suggestionsBox.innerHTML = ""
        }
    })

})