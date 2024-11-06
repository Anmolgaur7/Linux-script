#!/bin/bash
EXPENSE_FILE=~/expenses.txt

function add_expense {
    echo "$(date): $*" >> "$EXPENSE_FILE"
    echo "Expense added: $*"
}

function list_expenses {
    echo "Expense Report:"
    if [ -s "$EXPENSE_FILE" ]; then
        cat -n "$EXPENSE_FILE" || echo "No expenses recorded."
    else
        echo "No expenses recorded."
    fi
}

function delete_expense {
    if [ -z "$1" ]; then
        echo "Error: No line number provided."
        return
    fi

    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: Invalid line number."
        return
    fi

    # Use sed to delete the specific line
    sed -i.bak "${1}d" "$EXPENSE_FILE"
    echo "Expense on line $1 deleted."
}

case "$1" in
    add)
        shift
        if [ -z "$*" ]; then
            echo "Error: No expense description provided."
        else
            add_expense "$*"
        fi
        ;;
    list)
        list_expenses
        ;;
    delete)
        shift
        delete_expense "$1"
        ;;
    *)
        echo "Usage: $0 {add|list|delete} [description or line number]"
        ;;
esac

