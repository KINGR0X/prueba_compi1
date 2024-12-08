import * as Parser from './peg-parser';

export default function parseInput(input: string): any {
    try {
        Parser.parse(input);
    } catch (error) {
        return error as string;
    }
    return "Analisis exitoso";
}