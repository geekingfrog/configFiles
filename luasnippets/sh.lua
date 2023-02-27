return {
  s("bash", { t('#!/usr/bin/env bash') }),
  s("-euo", { t('set -euo pipefail') }),
  s("_scriptdir", { t('SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )') }),
}
