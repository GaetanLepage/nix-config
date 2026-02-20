# Fonction pour générer un hash court
generate_short_hash() {

    if which sha256sum >/dev/null 2>&1; then
        printf "$1" | sha256sum | head -c 7
    else
        printf "$1" | shasum -a 256 | head -c 7
    fi
}
# Fonction pour assainir le nom d'utilisateur
sanitize_username() {
    local username="$1"
    local sanitized
    # Convertir en minuscules
    sanitized=$(echo "$username" | tr '[:upper:]' '[:lower:]')
    # Remplacer les caractères non alphanumériques par des tirets
    sanitized=$(echo "$sanitized" | sed 's/[^a-z0-9]/-/g')
    # Supprimer les tirets en début de chaîne
    sanitized=$(echo "$sanitized" | sed 's/^-*//')
    # Vérifier si le nom d'utilisateur assaini est vide
    if [[ -z "$sanitized" ]]; then
        echo "Error: Username cannot be empty" >&2
        return 1
    fi
    # Tronquer si plus long que la longueur maximale
    local max_len=20
    if [[ ${#sanitized} -gt $max_len ]]; then
        sanitized="${sanitized:0:$max_len}"
    fi
    echo "$sanitized"
}

# Génération du nom de ressource
#
username="gaetan.lepage"

sanitized_username=$(sanitize_username "$username")
# if [[ $? -ne 0 ]]; then
#     exit 1
# fi

hash=$(generate_short_hash "$username")
resource_name="${sanitized_username}-${hash}"

echo $resource_name
